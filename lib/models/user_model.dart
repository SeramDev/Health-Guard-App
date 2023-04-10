part of "objects.dart";

@JsonSerializable()
class UserModel {
  String uid;
  String name;
  String email;
  String role;
  String img;

  UserModel(this.uid, this.name, this.email, this.role, this.img);

  //---------bind json data to user model
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  //---------convert user model into a json object
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
