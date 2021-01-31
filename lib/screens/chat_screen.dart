import 'package:flutter/material.dart';
import 'package:dima_app/utilities/constants.dart';
import 'package:dima_app/utilities/firebaseAuthentication.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;
//String receiverUID = '3Wj3IvH9L7V6iNrQ99TGPcjRFDo1';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  final String receiverUID;
  ChatScreen(this.receiverUID);

  @override
  _ChatScreenState createState() => _ChatScreenState(receiverUID);
}

class _ChatScreenState extends State<ChatScreen> {
  final String receiverUID;
  _ChatScreenState(this.receiverUID);
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText = '';

  @override
  void initState() {
    print('start');
    super.initState();
    loggedInUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        /*actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                Navigator.pop(context);
              }),
        ],*/
        title: Text('⚡️Chat'),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(receiverUID),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (messageText == '') return;
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'sent_time': DateTime.now(),
                        'text': messageText,
                        'sender_UID': loggedInUser.uid,
                        'receiver_UID': receiverUID,
                      });
                      messageText = '';
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final String receiverUID;
  MessagesStream(this.receiverUID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy('sent_time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageSender_UID = message.data()['sender_UID'] ?? '';
          final messageReceiver_UID = message.data()['receiver_UID'] ?? '';

          if ((messageSender_UID == loggedInUser.uid &&
                  messageReceiver_UID == receiverUID) ||
              (messageReceiver_UID == loggedInUser.uid &&
                  messageSender_UID == receiverUID)) {
            final messageText = message.data()['text'] ?? '';
            //final messageSender = message.data()['sender'] ?? '';
            final currentUser = loggedInUser.uid ?? '';

            final messageBubble = MessageBubble(
              text: messageText,
              isMe: currentUser == messageSender_UID,
            );

            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.isMe});

  //final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          /*   Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),*/
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? kPrimaryColor : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
