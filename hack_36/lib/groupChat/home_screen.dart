import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'chatScreen.dart';
import 'add.dart';

class HomeScreen2 extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('groups')
              .where('members', arrayContains: _auth.currentUser?.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  final chat = snapshot.data.documents[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          pp: chat.data()['group'],
                          groupMembers: List.from(chat['members']),
                        ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600].withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.red[200],
                              child: Text(
                                chat.data()['group'][0],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          chat.data()['group'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          child: null,
                                        ),
                                      ],
                                    ),
                                    //Text(
                                    //  ((chat.data()['time']).toDate()).toString(),
                                    //   style: TextStyle(
                                    //     fontSize: 11,
                                    //     fontWeight: FontWeight.w300,
                                    //     color: Colors.black54,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //   alignment: Alignment.topLeft,
                                //   child: Text(
                                //     "a",
                                //     style: TextStyle(
                                //       fontSize: 13,
                                //       color: Colors.black54,
                                //     ),
                                //     overflow: TextOverflow.ellipsis,
                                //     maxLines: 2,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[300],
        onPressed: () {
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddMembers(),
            ),
          );
        },
        child: Icon(Icons.group_add),
      ),
    );
  }
}
