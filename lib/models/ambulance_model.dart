part of "objects.dart";

@JsonSerializable()
class AmbulanceModel extends ConsumerModel{
  String uid;
  String ambulanceName;
  String hospitalName;
  String email;
  String role;

  AmbulanceModel(this.uid, this.ambulanceName, this.hospitalName, this.email, this.role);

  //---------bind json data to user model
  factory AmbulanceModel.fromJson(Map<String, dynamic> json) =>
      _$AmbulanceModelFromJson(json);

  //---------convert user model into a json object
  Map<String, dynamic> toJson() => _$AmbulanceModelToJson(this);
}
