import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpinghand/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/firebase',
    ],
  );
  // create user obj based on Firebase User

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, displayName: user.displayName)
        : null;
  }

  // auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with Gmail
  Future googleSignIn() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser _user = (await _auth.signInWithCredential(credential)).user;
      assert(_user.email != null);
      assert(_user.displayName != null);
      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);

      print("signed in " + _user.displayName + "\n" + _user.photoUrl);
      return _userFromFirebaseUser(_user);
      // return _user;
    } catch (e) {
      print("ERROR DAW " + e.toString());
      return null;
    }
  }

  // sign in email and password

  // Sign Out Google
  Future googleSignOut() async {
    try {
      _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in anonymously
  // we did not use this function. Just for testing
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // register email and password
  // we did not use this function. Just for testing

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  // we did not use this function. Just for testing
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
