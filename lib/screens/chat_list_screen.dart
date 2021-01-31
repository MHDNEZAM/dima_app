import 'package:dima_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shimmer/shimmer.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatListScreen extends StatefulWidget {
  static const String id = 'chat_list_screen';
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    print('start');
    super.initState();
    loggedInUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //backgroundColor: Settings.isDarkMode ? Colors.grey[900] : MyColors.blue,
        appBar: AppBar(
          leading: null,
          backgroundColor: kPrimaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Chats',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: MessagesListStream(),
            ),
          ),
        ),
      ),
    );
  }
}

class MessagesListStream extends StatelessWidget {
  MessagesListStream();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot1) {
        if (!snapshot1.hasData) {
          //todo
          return TextField();
        }
        return StreamBuilder(
            stream: _firestore.collection('messages').snapshots(),
            builder: (context, snapshot2) {
              if (!snapshot2.hasData) {
                //todo
                return TextField();
              }

              final users = snapshot1.data.docs;
              final messages = snapshot2.data.docs.reversed;

              List<ChatListViewItem> chatListViewItem = [];

              final chatListItems = ChatListViewItem(
                hasUnreadMessage: true,
                image: 'assets/images/profile/male.jpg',
                lastMessage:
                    "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                name: "Bree Jarvis",
                newMesssageCount: 8,
                time: "19:27 PM",
              );
              chatListViewItem.add(chatListItems);
              return ListView(
                children: chatListViewItem,
              );
            });
      },
    );

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          // .where(field)
          .orderBy('sent_time')
          .snapshots(),
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

          /* if ((messageSender_UID == loggedInUser.uid &&
                  messageReceiver_UID == receiverUID) ||
              (messageReceiver_UID == loggedInUser.uid &&
                  messageSender_UID == receiverUID)) */
          {
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

class ChatListViewItem extends StatelessWidget {
  final String image;
  final String name;
  final String lastMessage;
  final String time;
  final bool hasUnreadMessage;
  final int newMesssageCount;
  ChatListViewItem({
    Key key,
    this.image,
    this.name,
    this.lastMessage,
    this.time,
    this.hasUnreadMessage,
    this.newMesssageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: ListTile(
                  title: Text(
                    name,
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(image),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        time,
                        style: TextStyle(fontSize: 12),
                      ),
                      hasUnreadMessage
                          ? Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                  // color: myColors.orange,
                                  borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              )),
                              child: Center(
                                  child: Text(
                                newMesssageCount.toString(),
                                style: TextStyle(fontSize: 11),
                              )),
                            )
                          : SizedBox()
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(//todo
                          // builder: (context) => (),
                          ),
                    );
                  },
                ),
              ),
            ],
          ),
          Divider(
            endIndent: 12.0,
            indent: 12.0,
            height: 0,
          ),
        ],
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () {},
        ),
      ],
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

/*
ChatListViewItem(
hasUnreadMessage: true,
image: AssetImage('assets/images/person1.jpg'),
lastMessage:
"Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
name: "Bree Jarvis",
newMesssageCount: 8,
time: "19:27 PM",
),
ChatListViewItem(
hasUnreadMessage: true,
image: AssetImage('assets/images/person2.png'),
lastMessage:
"Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
name: "Alex",
newMesssageCount: 5,
time: "19:27 PM",
),
ChatListViewItem(
hasUnreadMessage: false,
image: AssetImage('assets/images/person3.jpg'),
lastMessage:
"Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
name: "Carson Sinclair",
newMesssageCount: 0,
time: "19:27 PM",
),
ChatListViewItem(
hasUnreadMessage: false,
image: AssetImage('assets/images/person4.png'),
lastMessage:
"Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
name: "Lucian Guerra",
newMesssageCount: 0,
time: "19:27 PM",
),
ChatListViewItem(
hasUnreadMessage: false,
image: AssetImage('assets/images/person5.jpg'),
lastMessage:
"Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
name: "Sophia-Rose Bush",
newMesssageCount: 0,
time: "19:27 PM",
),
ChatListViewItem(
hasUnreadMessage: false,
image: AssetImage('assets/images/person6.jpg'),
lastMessage:
"Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
name: "Mohammad",
newMesssageCount: 0,
time: "19:27 PM",
),
ChatListViewItem(
hasUnreadMessage: false,
image: AssetImage('assets/images/person7.jpg'),
lastMessage:
"Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
name: "Jimi Cooke",
newMesssageCount: 0,
time: "19:27 PM",
),
*/
