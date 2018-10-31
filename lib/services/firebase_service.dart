
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart' as fb;

/// wrapper around the firebase database
class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  fb.Storage _fbStorage;
  Stream<fb.User> authStateChanges;

  fb.App _fbApp;


  /// true if the user has signed in and then signs out
  /// false if the user is signed in or they have not yet signed in for this session
  bool _signedOut = false;



  @Injectable()
  FirebaseService() {
    _fbApp = fb.initializeApp(
        apiKey: "AIzaSyD7wSSRiMWAw44RRU68yqxZq5uksbQcOnk",
        authDomain: "chat1-724a3.firebaseapp.com",
        databaseURL: "https://chat1-724a3.firebaseio.com",
        storageBucket: "chat1-724a3.appspot.com",
        messagingSenderId: "5416414460");

    print('fb constructor called ');



    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth(_fbApp);


    _fbDatabase = fb.database();
    _fbStorage = fb.storage();
     authStateChanges = _fbAuth.onAuthStateChanged;


  }

  /// the root node for the database for the logged in user
  fb.DatabaseReference get root => _fbDatabase.ref('userData/' +  _fbAuth.currentUser.uid + '/');





  /// Performs a signin usinga google account with a popup.
  /// Throws [FirebaseServiceAuthException]
  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
       _signedOut = false;
    } catch (error) {
      throw FirebaseServiceAuthException("$runtimeType::login() -- $error");

    }
  }

  /// signs the user out of the firebase database
  void signOut() async {
    try {
      await _fbAuth.signOut();
      _signedOut = true;
    } catch (error) {
      throw FirebaseServiceAuthException(error.toString());
    }
  }

  /// Gets the display name of the google account user using this app.
  /// Returns null if noone is logged in
  String get userName {
    if (signedIn) {
      return  _fbAuth.currentUser.displayName;
    } else {
      return null;
    }
  }

  /// true if someone is signed in
  bool get signedIn =>  _fbAuth.currentUser != null;
}

/// Exception for Authentication errors thrown by the [FirebaseService] class
class FirebaseServiceAuthException implements Exception {

  String _message;

  FirebaseServiceAuthException(this._message) {}

  String toString() => _message;
}

  /**

  bool get signedOut => _signedOut;


  readDataByReference(String ref, Function callback) {
    try {
      fb.DatabaseReference dbRef = root.child(ref);
      Future<fb.QueryEvent> fqe = dbRef.once('value');
      fqe.then((qe) {
        callback(qe.snapshot.val());
      }).catchError((ex) {
        _exception.call(ex, null, '1809231025:' + ref.toString());
      });
    } catch (ex, stacktrace) {
      _exception.call(ex, stacktrace, '1809231022: ' + ref.toString());
    }
  }

  deleteByReference(String ref, Function callback) {
    fb.DatabaseReference dbRef = root.child(ref);
    Future f = dbRef.remove();

    f.then((d) {
      if (callback != null) {
        callback();
      }
    });
  }

  setByReference(String ref, Map m, Function callback) {

    fb.DatabaseReference dbRef = root.child(ref);

    Future f = dbRef.set(m);

    f.then((d) {
      if (callback != null) {
        callback();
      }
    }).catchError((e) {
      _exception.call(e);
    });
  }
      */



