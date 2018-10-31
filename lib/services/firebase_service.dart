
import 'dart:async';
import 'package:firebase/firebase.dart' as fb;


class FirebaseService {
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  fb.Storage _fbStorage;
  Stream<fb.User> authStateChanges;


  /// true if the user has signed in and then signs out
  /// false if the user is signed in or they have not yet signed in for this session
  bool _signedOut = false;




  FirebaseService() {
    fb.initializeApp(
        apiKey: "AIzaSyD7wSSRiMWAw44RRU68yqxZq5uksbQcOnk",
        authDomain: "chat1-724a3.firebaseapp.com",
        databaseURL: "https://chat1-724a3.firebaseio.com",
        storageBucket: "chat1-724a3.appspot.com",
        messagingSenderId: "5416414460");



    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();


    _fbDatabase = fb.database();
    _fbStorage = fb.storage();
     authStateChanges = _fbAuth.onAuthStateChanged;


  }

  fb.DatabaseReference get root => _fbDatabase.ref('userData/' +  _fbAuth.currentUser.uid + '/');



  Future signIn() async {
    try {

       await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
        _fbAuth.currentUser.getIdToken().then((s) {
       });
       _signedOut = false;
    } catch (error) {
      print("$runtimeType::login() -- $error");
    }
  }

  void signOut() async {
    await _fbAuth.signOut();
    _signedOut = true;
  }

  bool get signedIn =>  _fbAuth.currentUser != null;
  String get userName {
    if (signedIn) {
      return  _fbAuth.currentUser.displayName;
    } else {
      return null;
    }
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
}


