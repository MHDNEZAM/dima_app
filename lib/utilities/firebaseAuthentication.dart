import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String firebaseAuthenticationName;
String firebaseAuthenticationEmail;

//String imageUrl

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    //assert(user.photoURL != null);

    firebaseAuthenticationName = user.displayName;
    firebaseAuthenticationEmail = user.email;
    //imageUrl = user.photoURL;

    // Only taking the first part of the name, i.e., First Name
    if (firebaseAuthenticationName.contains(" ")) {
      firebaseAuthenticationName = firebaseAuthenticationName.substring(
          0, firebaseAuthenticationName.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    var collectionRef = _firestore.collection('users');
    var doc = await collectionRef.doc(user.uid).get();
    if (!doc.exists) {
      //doesn't exist
      _firestore.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'name': user.email.split('@')[0],
        'profileImage':
            'https://firebasestorage.googleapis.com/v0/b/property-6a8fc.appspot.com/o/uploads%2Fprofile%2FprofileImage.png?alt=media&token=2d073862-6fcc-451a-934f-67aac96860c9',
        'Sex': '',
      });
    }

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}
