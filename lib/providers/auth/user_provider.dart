import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_guard/models/consumer.dart';
import 'package:health_guard/screens/auth/login.dart';
import 'package:health_guard/screens/main/ambulance/ambulance_main_screen.dart';
import 'package:health_guard/screens/main/main_screen.dart';
import 'package:health_guard/screens/main/police_station/police_main_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../../controllers/auth_controller.dart';
import '../../models/objects.dart';
import '../../utils/util_functions.dart';

class UserProvider extends ChangeNotifier {
  ConsumerModel consumer = NoUser();

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
  Future<ConsumerModel> fetchUser(String id) async {
    try {
      //---------start the loader
      setLoading(true);

      ConsumerModel value = await AuthController().fetchUserData(id);
      consumer = value;
      notifyListeners();
      setLoading(false);
      return consumer;
    } catch (e) {
      Logger().e(e);
      return NoUser();
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
        ConsumerModel model = await fetchUser(user.uid);
        notifyListeners();
        print(model.runtimeType);

        print("done");

        if (model is UserModel) {
          UtilFunctions.navigateTo(context, const MainScreen());
        } else if (model is PoliceStationModel) {
          UtilFunctions.navigateTo(context, const PoliceMain());
        } else if (model is AmbulanceModel) {
          UtilFunctions.navigateTo(context, const AmbulanceMain());
        } else {
          print("no user received************************************");
        }
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
      String imgUrl = await AuthController().uploadAndUpdateProfileImage(
          context, (consumer as UserModel).uid, image);
      if (imgUrl != "") {
        //-------update the usermodel img feild with returned download url
        (consumer as UserModel).img = imgUrl;
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
