import 'package:json_annotation/json_annotation.dart';

part 'statusModel.g.dart';

@JsonSerializable()
class StatusModel {
  final String message;
  final String time;

  StatusModel({this.message, this.time});

  factory StatusModel.fromJson(Map<String, dynamic> json) =>
      _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
