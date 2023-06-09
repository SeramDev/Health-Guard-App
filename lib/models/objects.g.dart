// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uid'] as String,
      json['name'] as String,
      json['age'] as int,
      json['gender'] as String,
      json['email'] as String,
      json['role'] as String,
      json['img'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'email': instance.email,
      'role': instance.role,
      'img': instance.img,
    };

SensorDataModel _$SensorDataModelFromJson(Map<String, dynamic> json) =>
    SensorDataModel(
      (json['heartRate'] as num).toDouble(),
      (json['oxygenSaturation'] as num).toDouble(),
      (json['temperature'] as num).toDouble(),
      json['systolicBloodPressure'] as int,
      json['diastolicBloodPressure'] as int,
      json['status'] as String,
      json['isEmergencyButtonPressed'] as bool,
    );

Map<String, dynamic> _$SensorDataModelToJson(SensorDataModel instance) =>
    <String, dynamic>{
      'heartRate': instance.heartRate,
      'oxygenSaturation': instance.oxygenSaturation,
      'temperature': instance.temperature,
      'systolicBloodPressure': instance.systolicBloodPressure,
      'diastolicBloodPressure': instance.diastolicBloodPressure,
      'status': instance.status,
      'isEmergencyButtonPressed': instance.isEmergencyButtonPressed,
    };

PoliceStationModel _$PoliceStationModelFromJson(Map<String, dynamic> json) =>
    PoliceStationModel(
      json['uid'] as String,
      json['policeStationName'] as String,
      json['PoliceStationEmail'] as String,
      json['PoliceStationAddress'] as String,
      json['role'] as String,
    );

Map<String, dynamic> _$PoliceStationModelToJson(PoliceStationModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'policeStationName': instance.policeStationName,
      'PoliceStationEmail': instance.PoliceStationEmail,
      'PoliceStationAddress': instance.PoliceStationAddress,
      'role': instance.role,
    };

AmbulanceModel _$AmbulanceModelFromJson(Map<String, dynamic> json) =>
    AmbulanceModel(
      json['uid'] as String,
      json['ambulanceName'] as String,
      json['hospitalName'] as String,
      json['email'] as String,
      json['role'] as String,
    );

Map<String, dynamic> _$AmbulanceModelToJson(AmbulanceModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'ambulanceName': instance.ambulanceName,
      'hospitalName': instance.hospitalName,
      'email': instance.email,
      'role': instance.role,
    };
