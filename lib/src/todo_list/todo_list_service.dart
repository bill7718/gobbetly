import 'dart:async';

import 'package:angular/core.dart';
import 'package:gobbetly/services/firebase_service.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class TodoListService {
  List<String> mockTodoList = <String>[];

  Future<List<String>> getTodoList() async => mockTodoList;

  FirebaseService _firebaseService;

  TodoListService(this._firebaseService) {

  }

  signin() {
    _firebaseService.signIn();
  }

  get username =>_firebaseService.userName;

}
