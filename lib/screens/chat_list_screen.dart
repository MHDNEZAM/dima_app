import 'package:dima_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'package:intl/intl.dart';
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
          automaticallyImplyLeading: false,
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
  final _auth = FirebaseAuth.instance;

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
            stream: _firestore
                .collection('messages')
                .orderBy('sent_time')
                .snapshots(),
            builder: (context, snapshot2) {
              if (!snapshot2.hasData) {
                //todo
                return TextField();
              }
              List<ChatListViewItem> chatListViewItem = [];

              final users = snapshot1.data.docs;
              final messages = snapshot2.data.docs.reversed;

              for (var user in users) {
                if (user.data()['uid'] != _auth.currentUser.uid) {
                  //message.data()['sender_UID']

                  for (var message in messages) {
                    //print("sender_UID" + message.data()['sender_UID']);
                    //print("_auth.currentUser.uid" + _auth.currentUser.uid);

                    //print("receiver_UID" + message.data()['receiver_UID']);
                    //print(" user.data()['uid'])" + user.data()['uid']);
                    //print("-----------------------------------------------");

                    if ((message.data()['sender_UID'] ==
                                _auth.currentUser.uid &&
                            message.data()['receiver_UID'] ==
                                user.data()['uid']) ||
                        (message.data()['receiver_UID'] ==
                                _auth.currentUser.uid &&
                            message.data()['sender_UID'] ==
                                user.data()['uid'])) {
                      //start
                      print('start s');
                      String uid = '';
                      if (message.data()['sender_UID'] ==
                          _auth.currentUser.uid) {
                        uid = message.data()['receiver_UID'];
                      } else {
                        uid = user.data()['uid'];
                      }

                      int msgCount = 0;

                      if (message.data()['receiver_UID'] ==
                          _auth.currentUser.uid) {
                        for (var message in messages) {
                          if (message.data()['receiver_UID'] ==
                                  _auth.currentUser.uid &&
                              message.data()['sender_UID'] ==
                                  user.data()['uid'] &&
                              message.data()['read'] == false) {
                            msgCount = msgCount + 1;
                          }
                        }
                      }

                      final chatListItems = ChatListViewItem(
                        uid: uid,
                        hasUnreadMessage: true,
                        image:
                            'http://clipart-library.com/images_k/male-silhouette-profile/male-silhouette-profile-12.png',
                        lastMessage: message.data()['text'],
                        name: user.data()['name'],
                        newMesssageCount: msgCount,
                        time:
                            readTimestamp(message.data()['sent_time'].seconds),
                      );
                      chatListViewItem.add(chatListItems);

                      break;
                    }
                  }
                }
              }

              // Sorting string by comparing the length
              //chatListViewItem.sort((a, b) => a.time.compareTo(b.time));
              return ListView(
                children: chatListViewItem,
              );
            });
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
  final String uid;
  ChatListViewItem(
      {Key key,
      this.image,
      this.name,
      this.lastMessage,
      this.time,
      this.hasUnreadMessage,
      this.newMesssageCount,
      this.uid})
      : super(key: key);

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
                    backgroundImage: NetworkImage(image),
                    backgroundColor: kPrimaryLightColor,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        time ?? '',
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
                                newMesssageCount.toString() ?? '',
                                style: TextStyle(fontSize: 11),
                              )),
                            )
                          : SizedBox()
                    ],
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => ChatScreen(uid),
                          fullscreenDialog: true),
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
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' DAY AGO';
    } else {
      time = diff.inDays.toString() + ' DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    }
  }

  return time;
}
