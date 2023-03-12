import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/src/controllers/message_controller.dart';
import 'package:group_app/src/helper/k_log.dart';
import 'package:group_app/src/models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../components/other_msg_widget.dart';
import '../components/own_msg_widget.dart';

class GroupPage extends StatefulWidget {
  final String name;
  final String userId;

  const GroupPage({super.key, required this.name, required this.userId});
  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final messageC = Get.put(MessageController());
  late IO.Socket socket;
  List<MessageModel> listMsg = [];
  TextEditingController msgController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  connect() {
    // Dart client
    log('message');

    socket = IO.io(
        'http://192.168.100.116:8081',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.onConnect((_) {
      log('Socket connect');

      socket.on('getMsg', (data) {
        if (data['userId'] != widget.userId) {
          messageC.msgList.add(MessageModel(
              msg: data['msg'],
              type: data['type'],
              senderName: data['senderName'],
              userId: data['userId'],
              createdAt: data['createdAt']));
        }
      });
    });

    socket.onDisconnect((data) {
      log('Socket disconnect');
    });

    socket.connect();
  }

  void sendMsg({
    required String msg,
    required String senderName,
    required String userId,
  }) {
    final ownMsg = MessageModel(
      msg: msg,
      type: 'ownMsg',
      senderName: senderName,
      userId: userId,
      createdAt: DateTime.now().toString(),
    );

    messageC.msgList.add(ownMsg);

    socket.emit('sendMsg', {
      "msg": msg,
      "type": 'ownMsg',
      "senderName": senderName,
      "userId": userId,
      "createdAt": DateTime.now().toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            // Center(child: Text(widget.name)),
            SizedBox(height: 10),
            Expanded(
              child: messageC.msgList.isEmpty
                  ? Center(
                      child: Text('No Message'),
                    )
                  : ListView.builder(
                      itemCount: messageC.msgList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = messageC.msgList[index];

                        if (item.type == 'ownMsg') {
                          return OwnMsgWidget(
                            msg: item.msg!,
                            senderName: item.senderName!,
                            createdAt: item.createdAt!,
                          );
                        } else {
                          return OtherMsgWidget(
                            msg: item.msg!,
                            senderName: item.senderName!,
                            createdAt: item.createdAt!,
                          );
                        }
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                  hintText: 'Type here ...',
                  suffixIcon: IconButton(
                    onPressed: () {
                      final msg = msgController.text.trim();
                      if (msg.isNotEmpty) {
                        sendMsg(
                          msg: msg,
                          senderName: widget.name,
                          userId: widget.userId,
                        );

                        msgController.clear();
                      }
                    },
                    icon: Icon(Icons.send),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(width: 1),
                  ),
                  filled: true,
                  isDense: true,
                ),
                enabled: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
