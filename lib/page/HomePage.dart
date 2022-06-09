import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isolation_aid_kit/firebase/auth/AuthUtils.dart';
import 'package:isolation_aid_kit/firebase/store/Request.dart';
import 'package:isolation_aid_kit/page/AddPage.dart';
import 'package:isolation_aid_kit/page/SearchPage.dart';

import 'DetailPage.dart';
import 'HistoryPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: AssetImage("assets/icon.png"),
            ),
          ),
        ),
        title: Text(
          'Isolation Aid Kit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     Icons.settings,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     getAllRequests();
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              signOut();
              Navigator.pushReplacementNamed(
                context,
                '/login',
              );
            },
          ),
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddPage();
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 40,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SearchPage();
                          },
                        ),
                      );
                    }),
                Text(
                  "Wszystkie",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Historia",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.history),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return HistoryPage();
                          },
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blue,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('request')
          .where('owner', isEqualTo: getUserId())//.where('status', isNotEqualTo: 'closed')//.where('owner', isNotEqualTo: getUserId())
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
                    border: Border.all(
                        color: getColorByStatus(document.data()['status']),
                        width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                    color: getColorByStatus(document.data()['status'])),
                child: ListTile(
                  title: Text(document.data()['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18)),
                  subtitle: Text(
                    document.data()['description'],
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                  trailing: getIconStatus(document.data()['status']),
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

Icon getIconStatus(String status) {
  if (status == 'new') {
    return Icon(Icons.sync);
  } else if (status == 'attached') {
    return Icon(Icons.check);
  }
  return Icon(Icons.done_all);
}

Color getColorByStatus(String status) {
  if (status == 'new') {
    return Colors.green;
  } else if (status == 'attached') {
    return Colors.orange;
  }
  return Colors.grey;
}
