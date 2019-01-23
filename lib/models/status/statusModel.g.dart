// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statusModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) {
  return StatusModel(
      message: json['message'] as String, time: json['time'] as String);
}

Map<String, dynamic> _$StatusModelToJson(StatusModel instance) =>
    <String, dynamic>{'message': instance.message, 'time': instance.time};
