import 'package:flutter/material.dart';
import 'package:yourhomeyourrent/helper/chat_item_model.dart';

class ChatOfHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<ChatOfHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          textAlign: TextAlign.center,
        ),
        elevation: 90.0,
      ),
      body: ListView.builder(
        itemCount: chatItemData.length,
        itemBuilder: (context, i) => new Column(
          children: [
            Divider(
              height: 10.0,
            ),
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundImage: NetworkImage(chatItemData[i].avatarUrl),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chatItemData[i].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      chatItemData[i].time,
                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ],
                ),
                subtitle: Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    chatItemData[i].message,
                    style: TextStyle(color: Colors.grey, fontSize: 15.0),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
