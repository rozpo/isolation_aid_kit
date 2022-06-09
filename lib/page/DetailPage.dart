import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isolation_aid_kit/firebase/auth/AuthUtils.dart';
import 'package:isolation_aid_kit/firebase/store/Request.dart';

import 'HomePage.dart';

DetailPage openDetailPage(DocumentSnapshot document) {
  return DetailPage(
    documentId: document.id,
    title: document.data()['title'],
    address: document.data()['address'],
    created: document.data()['created'],
    status: document.data()['status'],
    username: document.data()['username'],
    volunteer: document.data()['volunteer'],
    description: document.data()['description'],
    owner: document.data()['owner'],
    volunteerName: document.data()['volunteerName'],
  );
}

class DetailPage extends StatefulWidget {
  final String documentId;
  final String title;
  final String description;
  final String address;
  final String status;
  final String created;
  final String username;
  final String volunteer;
  final String volunteerName;
  final String owner;

  const DetailPage({Key key,
    this.documentId,
    this.title,
    this.description,
    this.address,
    this.status,
    this.created,
    this.username,
    this.owner,
    this.volunteer,
    this.volunteerName})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "wstecz",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Szczegóły zlecenia",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text("Nazwa:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text(widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18))),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text("Opis:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ],
                ),
                Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Text(widget.description,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                        maxLines: 5,
                        textAlign: TextAlign.left)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text("Lokalizacja:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text(widget.address,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16))),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("Dodatkowe informacje",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text("Autor:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text(widget.username,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16))),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text("Data utworzenia:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text(widget.created,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16))),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text("Wolontariusz:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text(widget.volunteerName,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16))),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text("Status:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ],
                ),
                Container(
                    child: (widget.status == 'new')
                        ? Text("Gotowe do przyjęcia",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16))
                        : (widget.status == 'attached')
                        ? Text("W trakcie realizacji",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16))
                        : Text("Zgłoszenie zostało zamknięte",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16))),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: (widget.owner == getUserId() &&
            widget.status == 'new') ? FloatingActionButton.extended(
          backgroundColor: Colors.red,
          label: Text("Usuń zgłoszenie"),
          icon: Icon(Icons.cancel),
          onPressed: () {
            deleteRequest(widget.documentId);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
        ) :
        (widget.status == 'new') ? FloatingActionButton.extended(
          backgroundColor: Colors.green,
          label: Text("Zaakceptuj"),
          icon: Icon(Icons.check),
          onPressed: () {
            setVolunteer(widget.documentId, getUserId());
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
        ) :
        (widget.status == 'attached' && widget.owner == getUserId())
            ? FloatingActionButton.extended(
          backgroundColor: Colors.orange,
          label: Text("Zamknij zgłoszenie"),
          icon: Icon(Icons.check),
          onPressed: () {
            closeRequest(widget.documentId);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
        )
            : FloatingActionButton.extended(
          backgroundColor: Colors.grey,
          label: Text("Zakończone"),
          icon: Icon(Icons.done_all),
          onPressed: () {
            closeRequest(widget.documentId);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
        )
    );
  }
}
