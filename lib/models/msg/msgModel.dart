import 'package:json_annotation/json_annotation.dart';

part 'msgModel.g.dart';

@JsonSerializable()
class MsgModel {
   final String message;

  MsgModel({this.message});


  factory MsgModel.fromJson(Map<String, dynamic> json) => _$MsgModelFromJson(json);

  Map<String, dynamic> toJson() => _$MsgModelToJson(this);
}

