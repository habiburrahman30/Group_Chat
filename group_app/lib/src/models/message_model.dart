// class MessageModel {
//   final String msg;
//   final String type;
//   final String senderName;

//   MessageModel({
//     required this.msg,
//     required this.type,
//     required this.senderName,
//   });
// }

import 'package:json_annotation/json_annotation.dart';
part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final String? userId;
  final String? msg;
  final String? type;
  final String? senderName;
  final String? createdAt;

  MessageModel({
    this.userId,
    this.msg,
    this.type,
    this.senderName,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
