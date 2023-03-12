import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class OwnMsgWidget extends StatelessWidget {
  final String msg;
  final String senderName;
  final String createdAt;

  const OwnMsgWidget(
      {super.key,
      required this.msg,
      required this.senderName,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 60,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          senderName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(msg),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    '${timeago.format(DateTime.parse(createdAt), allowFromNow: true, locale: 'en_short')}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 3),
            CircleAvatar(
              radius: 16,
              child: Icon(Icons.person_rounded),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
