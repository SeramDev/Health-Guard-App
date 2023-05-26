part of "objects.dart";

@JsonSerializable()
class UserModel extends ConsumerModel{
  String uid;
  String name;
  int age;
  String gender;
  String email;
  String role;
  String img;

  UserModel(this.uid, this.name, this.age, this.gender, this.email, this.role,
      this.img);

  //---------bind json data to user model
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  //---------convert user model into a json object
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
