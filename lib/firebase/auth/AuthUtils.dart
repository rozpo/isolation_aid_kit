import 'package:firebase_auth/firebase_auth.dart';

bool isUserSignIn() {
  if (FirebaseAuth.instance.currentUser == null) {
    return false;
  }
  return true;
}

String getUserName() {
  User user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.displayName;
  }
  return 'error';
}

String getUserId() {
  User user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  }
  return null;
}

bool isUserMatch(String userId) {
  return FirebaseAuth.instance.currentUser.uid == userId ? true : false;
}

void signOut() async {
  await FirebaseAuth.instance.signOut();
}
