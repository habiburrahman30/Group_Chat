// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      userId: json['userId'] as String?,
      msg: json['msg'] as String?,
      type: json['type'] as String?,
      senderName: json['senderName'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'msg': instance.msg,
      'type': instance.type,
      'senderName': instance.senderName,
      'createdAt': instance.createdAt,
    };
