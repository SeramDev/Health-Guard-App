part of "objects.dart";

@JsonSerializable()
class SensorDataModel {
  final double heartRate;
  final double oxygenSaturation;
  final double temperature;
  final double systolicBloodPressure;
  final double diastolicBloodPressure;
  final double longitude;
  final double latitude;
  final String status;

  SensorDataModel(
    this.heartRate,
    this.oxygenSaturation,
    this.temperature,
    this.systolicBloodPressure,
    this.diastolicBloodPressure,
    this.longitude,
    this.latitude,
    this.status,
  );

  //bind json data to sensorData model
  factory SensorDataModel.fromJson(Map<String, dynamic> json) =>
      _$SensorDataModelFromJson(json);

  //---------convert sensorData model into a json object
  Map<String, dynamic> toJson() => _$SensorDataModelToJson(this);
}
