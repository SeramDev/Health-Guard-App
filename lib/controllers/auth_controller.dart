import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_guard/models/consumer.dart';
import 'package:health_guard/screens/auth/login.dart';
import 'package:health_guard/utils/util_functions.dart';
import 'package:logger/logger.dart';
import '../models/objects.dart';
import '../utils/alert_helper.dart';
import '../utils/assets_constants.dart';
import 'file_upload_controller.dart';

class AuthController {
  //------------firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  //------------create the user collection refference
  CollectionReference consumers =
      FirebaseFirestore.instance.collection('consumers');

  //------------signup function
  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
    String name,
    int age,
    String gender,
    String role,
  ) async {
    try {
      //---------send email and password to the firebase and create a user
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        //---------------check if the user credential object is not null
        if (value.user != null) {
          //----------------save other user data in cloud firestore
          await saveUserData(
            UserModel(
              value.user!.uid,
              name,
              age,
              gender,
              email,
              role,
              AssetConstants.profileImgUrl,
            ),
          );
          //----------------if user created successfully show an alert
          // ignore: use_build_context_synchronously
          AlertHelper.showAlert(
              context, DialogType.SUCCES, "Success", "Registration Success!");
        }
      });
    } on FirebaseAuthException catch (e) {
      //----------show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.code);
    } catch (e) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  Future<void> registerPoliceStation(
    BuildContext context,
    String email,
    String password,
    String address,
    String name,
    String role,
  ) async {
    try {
      //---------send email and password to the firebase and create a user
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        //---------------check if the user credential object is not null
        if (value.user != null) {
          //----------------save other user data in cloud firestore
          await savePoliceData(
            PoliceStationModel(
              value.user!.uid,
              name,
              email,
              address,
              role,
            ),
          );
          //----------------if user created successfully show an alert
          // ignore: use_build_context_synchronously
          AlertHelper.showAlert(
              context, DialogType.SUCCES, "Success", "Registration Success!");
        }
      });
    } on FirebaseAuthException catch (e) {
      //----------show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.code);
    } catch (e) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  Future<void> registerAmbulance(
    BuildContext context,
    String email,
    String password,
    String hospital,
    String name,
    String role,
  ) async {
    try {
      //---------send email and password to the firebase and create a user
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        //---------------check if the user credential object is not null
        if (value.user != null) {
          //----------------save other user data in cloud firestore
          await saveAmbulanceData(
            AmbulanceModel(
              value.user!.uid,
              name,
              hospital,
              email,
              role,
            ),
          );
          //----------------if user created successfully show an alert
          // ignore: use_build_context_synchronously
          AlertHelper.showAlert(
              context, DialogType.SUCCES, "Success", "Registration Success!");
        }
      });
    } on FirebaseAuthException catch (e) {
      //----------show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.code);
    } catch (e) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  //-------------save user data in firestore cloud
  Future<void> saveUserData(UserModel model) async {
    return consumers
        .doc(model.uid)
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("user data saved"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //-------------save police data in firestore cloud
  Future<void> savePoliceData(PoliceStationModel model) async {
    return consumers
        .doc(model.uid)
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("police data saved"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //-------------save ambulance data in firestore cloud
  Future<void> saveAmbulanceData(AmbulanceModel model) async {
    return consumers
        .doc(model.uid)
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("ambulance data saved"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //-------------fetch user data saved in cloud firestore
  Future<ConsumerModel> fetchUserData(String uid) async {
    try {
      //---------firebase query that fetch user data
      DocumentSnapshot snapshot = await consumers.doc(uid).get();
      print(snapshot.data());

      if (snapshot.data() != null) {
        print((snapshot.data() as Map<String, dynamic>));
        String role = (snapshot.data() as Map<String, dynamic>)["role"];
        if (role == "User") {
          print("**************************************");
          //---------mapping fetch data to user model
          UserModel model =
              UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
          return model;
        } else if (role == "Police Station") {
          //---------mapping fetch data to police model
          PoliceStationModel model = PoliceStationModel.fromJson(
              snapshot.data() as Map<String, dynamic>);
          return model;
        } else {
          //---------mapping fetch data to ambulance model
          AmbulanceModel model =
              AmbulanceModel.fromJson(snapshot.data() as Map<String, dynamic>);
          return model;
        }
      } else {
        return NoUser();
      }
    } catch (e) {
      Logger().e(e);
      return NoUser();
    }
  }

  //-------------sign in function
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      //---------send email and password to the firebase and check if the user is exist or not
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      //----------show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.code);
    } catch (e) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  //-------------signout function
  Future<void> logOut(BuildContext context) async {
    UtilFunctions.navigateTo(context, const Login());
    await FirebaseAuth.instance.signOut();
  }

  //-------------send password reset email
  Future<void> sendPassResetEmail(BuildContext context, String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      //-------------show dialog when the email is sent
      AlertHelper.showAlert(context, DialogType.SUCCES, "Reset Email Sent!",
          "Please check your inbox");
    });
  }

  //-------------upload and update user profile and return image url
  Future<String> uploadAndUpdateProfileImage(
    BuildContext context,
    String uid,
    File image,
  ) async {
    try {
      //-----------uploading the image file to profile images
      UploadTask? task =
          FileUploadController.uploadFile(image, "profileImages");

      final snapshot = await task!.whenComplete(() {});

      //-----------getting the download url
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      //-----------saving the products data in cloud firestore
      await consumers.doc(uid).update(
        {
          'img': downloadUrl,
        },
      );

      return downloadUrl;
    } catch (e) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
      return "";
    }
  }
}
