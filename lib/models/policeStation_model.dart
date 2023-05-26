part of "objects.dart";

@JsonSerializable()
class PoliceStationModel extends ConsumerModel{
  String uid;
  String policeStationName;
  String PoliceStationEmail;
  String PoliceStationAddress;
  String role;

  PoliceStationModel(this.uid, this.policeStationName, this.PoliceStationEmail,
      this.PoliceStationAddress, this.role);

  //---------bind json data to user model
  factory PoliceStationModel.fromJson(Map<String, dynamic> json) =>
      _$PoliceStationModelFromJson(json);

  //---------convert user model into a json object
  Map<String, dynamic> toJson() => _$PoliceStationModelToJson(this);
}
