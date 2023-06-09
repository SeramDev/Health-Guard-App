part of "objects.dart";

@JsonSerializable()
class SensorDataModel {
  final double heartRate;
  final double oxygenSaturation;
  final double temperature;
  final int systolicBloodPressure;
  final int diastolicBloodPressure;
  final String status;
  final bool isEmergencyButtonPressed;

  SensorDataModel(
    this.heartRate,
    this.oxygenSaturation,
    this.temperature,
    this.systolicBloodPressure,
    this.diastolicBloodPressure,
    this.status,
    this.isEmergencyButtonPressed,
  );

  //bind json data to sensorData model
  factory SensorDataModel.fromJson(Map<String, dynamic> json) =>
      _$SensorDataModelFromJson(json);

  //---------convert sensorData model into a json object
  Map<String, dynamic> toJson() => _$SensorDataModelToJson(this);
}
