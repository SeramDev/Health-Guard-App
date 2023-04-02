// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uid'] as String,
      json['name'] as String,
      json['email'] as String,
      json['img'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'img': instance.img,
    };

SensorDataModel _$SensorDataModelFromJson(Map<String, dynamic> json) =>
    SensorDataModel(
      (json['heartRate'] as num).toDouble(),
      (json['oxygenSaturation'] as num).toDouble(),
      (json['temperature'] as num).toDouble(),
      (json['systolicBloodPressure'] as num).toDouble(),
      (json['diastolicBloodPressure'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      (json['latitude'] as num).toDouble(),
      json['status'] as String,
    );

Map<String, dynamic> _$SensorDataModelToJson(SensorDataModel instance) =>
    <String, dynamic>{
      'heartRate': instance.heartRate,
      'oxygenSaturation': instance.oxygenSaturation,
      'temperature': instance.temperature,
      'systolicBloodPressure': instance.systolicBloodPressure,
      'diastolicBloodPressure': instance.diastolicBloodPressure,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'status': instance.status,
    };
