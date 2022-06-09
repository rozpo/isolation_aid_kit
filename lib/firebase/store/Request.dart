import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:isolation_aid_kit/firebase/auth/AuthUtils.dart';

void getAllRequests() {
  FirebaseFirestore.instance
      .collection('request')
      .get()
      .then((QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) {
              print('title: ' + doc["title"]);
              print('description: ' + doc["description"]);
            })
          });
}

void getUserRequests() {
  FirebaseFirestore.instance
      .collection('request')
      .get()
      .then((QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) {
              print('title: ' + doc["title"]);
              print('description: ' + doc["description"]);
            })
          });
}

void addRequest(String title, String description, String address) {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
  FirebaseFirestore.instance
      .collection('request')
      .add({
        'address': address,
        'title': title,
        'description': description,
        'owner': getUserId(),
        'created': formattedDate,
        'username': getUserName(),
        'status': 'new',
        'volunteer': '',
        'volunteerName': 'brak',
      })
      .then((value) => print("Request Added"))
      .catchError((error) => print("Failed to add request: $error"));
}

void setVolunteer(String documentId, String volunteerId) {
  FirebaseFirestore.instance
      .collection('request')
      .doc(documentId)
      .update({'volunteer': volunteerId, 'status': 'attached', 'volunteerName': getUserName()});
}

void closeRequest(String documentId) {
  FirebaseFirestore.instance
      .collection('request')
      .doc(documentId)
      .update({'status': 'closed'});
}

bool checkNewStatus(String documentId) {
  FirebaseFirestore.instance
      .collection('request')
      .doc(documentId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        print("rozpo" + documentSnapshot.data()['status']);
        if (documentSnapshot.data()['status'] == 'new') {
          print("true");
          return true;
        } else {
          return false;
        }
        // return documentSnapshot.data()['status'];
  });
  return false;
  // var doc = FirebaseFirestore.instance.collection('request').doc(documentId).get();
  // var value = doc.data.d
  //
  // String status = doc.then((value) => value['status'].toString());
  // print("rozpo status " + status);
  // if (status == 'new') {
  //   return true;
  // }
  // return false;
}

void deleteRequest(String documentId) {
  FirebaseFirestore.instance
      .collection('request').doc(documentId).delete();
}