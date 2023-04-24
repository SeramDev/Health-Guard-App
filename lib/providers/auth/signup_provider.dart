import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/alert_helper.dart';

class SignUpProvider extends ChangeNotifier {
  //---------email controller
  final _emailController = TextEditingController();
  //---------get email controller
  TextEditingController get emailController => _emailController;

  //---------email controller
  final _ageController = TextEditingController();
  //---------get email controller
  TextEditingController get ageController => _ageController;

  //---------password controller
  final _passwordController = TextEditingController();
  //---------get password controller
  TextEditingController get passwordController => _passwordController;

  //---------name controller
  final _nameController = TextEditingController();
  //---------get name controller
  TextEditingController get nameController => _nameController;

  //---------role dropdown controller
  String _roleController = "User";
  //---------get dropdown controller
  String get roleController => _roleController;

  //---------gender dropdown controller
  String _genderController = "Male";
  //---------get dropdown controller
  String get genderController => _genderController;

  //---------store loading state
  bool _isLoading = false;
  //---------get loading state
  bool get isLoading => _isLoading;

  //---------change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //---------store selected dropdown option
  void setSelectedOption(String val) {
    _roleController = val;
    notifyListeners();
  }

  //---------store selected gender
  void setSelectedGender(String val) {
    _genderController = val;
    notifyListeners();
  }

  //-------------validate textfields function
  bool validateFields(BuildContext context) {
    //-------first checking all the textfields are empty or not
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _ageController.text.isEmpty) {
      AlertHelper.showAlert(
          context, DialogType.ERROR, "ERROR", "Please fill all the fields");
      return false;
    } else if (!_emailController.text.contains("@")) {
      AlertHelper.showAlert(
          context, DialogType.ERROR, "ERROR", "Please enter a valid email");
      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR",
          "Password must have more than 6 digits");
      return false;
    } else {
      return true;
    }
  }

  //-------------start signup process
  Future<void> startSignup(BuildContext context) async {
    try {
      if (validateFields(context)) {
        //------start the loader
        setLoading(true);

        await AuthController().registerUser(
            context,
            _emailController.text,
            _passwordController.text,
            _nameController.text,
            int.parse(_ageController.text),
            _genderController,
            _roleController);

        //------clear textfields
        _emailController.clear();
        _passwordController.clear();
        _nameController.clear();
        _ageController.clear;

        //------stop the loader
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Logger().e(e);
      AlertHelper.showAlert(context, DialogType.ERROR, "Error", e.toString());
    }
  }
}
