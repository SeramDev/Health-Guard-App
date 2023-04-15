import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_guard/providers/auth/sensorData_provider.dart';
import 'package:health_guard/screens/auth/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../models/objects.dart';
import '../../screens/main/main_screen.dart';
import '../../utils/util_functions.dart';

class UserProvider extends ChangeNotifier {
  //---------local user model
  late UserModel _userModel;
  //---------get user model
  UserModel get userModel => _userModel;

  //---------store loading state
  bool _isLoading = false;
  //---------get loading state
  bool get isLoading => _isLoading;

  //---------change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //---------fetch single user data
  Future<void> fetchUser(String id) async {
    try {
      //---------start the loader
      setLoading(true);

      await AuthController().fetchUserData(id).then((value) {
        if (value != null) {
          _userModel = value;
          //---------calling this to notify that usermodel has been set
          notifyListeners();

          //---------stop the loader
          setLoading(false);
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //-------------initialize and check whether the user is signed in or not
  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Logger().i('User is currently signed out!');
        UtilFunctions.navigateTo(context, const Login());
      } else {
        Logger().i('User is signed in!');
        await fetchUser(user.uid);

        // ignore: use_build_context_synchronously
        Provider.of<SensorDataProvider>(context, listen: false)
            .fetchSensorData();
        // ignore: use_build_context_synchronously
        UtilFunctions.navigateToForwardOnly(context, const MainScreen());
      }
    });
  }

  //-------------pick upload and update user profile image
  //-------------pick an image

  //---------image picker instance
  final ImagePicker _picker = ImagePicker();

  //-------------file object
  File _image = File("");

  //-------------getter for image file
  File get getImage => _image;

  //-------------a function to pick a file from gallery
  Future<void> selectImageAndUpload(BuildContext context) async {
    try {
      // Pick an image
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      //----check if the user has picked a file or not
      if (pickedFile != null) {
        //-----assigning to the file object
        _image = File(pickedFile.path);

        //-----start uploading the image after picking
        // ignore: use_build_context_synchronously
        updateProfileImage(context, _image);
        notifyListeners();
      } else {
        Logger().w("No image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //-------upload and update profile image
  Future<void> updateProfileImage(BuildContext context, File image) async {
    try {
      //------start the loader
      setLoading(true);

      //------start uploading the image
      String imgUrl = await AuthController()
          .uploadAndUpdateProfileImage(context, userModel.uid, image);
      if (imgUrl != "") {
        //-------update the usermodel img feild with returned download url
        _userModel.img = imgUrl;
        notifyListeners();

        //-----stop the loader
        setLoading(false);
      }
    } catch (e) {
      Logger().e(e);

      //-----stop the loader
      setLoading(false);
    }
  }
}
