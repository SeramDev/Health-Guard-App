import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_guard/screens/auth/login.dart';
import 'package:logger/logger.dart';
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
        UtilFunctions.navigateTo(context, const MainScreen());
      }
    });
  }
}
