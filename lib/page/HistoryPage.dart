import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isolation_aid_kit/firebase/auth/AuthUtils.dart';
import 'package:isolation_aid_kit/page/DetailPage.dart';

import 'HomePage.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historia', style: TextStyle(fontWeight: FontWeight.bold),)),
      body: _buildBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey,
        label: Text("Wróć"),
        icon: Icon(Icons.undo),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('request')
          .where('status', isEqualTo: 'closed')//.where('owner', isNotEqualTo: getUserId())
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new ListView(
          padding: const EdgeInsets.only(top: 20.0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Padding(
              key: ValueKey(new Text(document.data()['title'])),
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                // color: getColorByStatus(document.data()['status'])),
                child: ListTile(
                  title: Text(document.data()['title'], style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                  subtitle: Text(document.data()['description'], style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),),
                  trailing: Text(document.data()['username'], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),),
                  onTap: () {
                    print(document.data());
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return openDetailPage(document);
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
