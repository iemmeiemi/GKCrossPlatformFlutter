import 'package:flutter/foundation.dart';
import 'package:giuaky/data/User.dart';
import 'package:giuaky/data/UserFirebase.dart';

class UserViewModel extends ChangeNotifier{
  late final UserFirebase _userFirebase;
  late List<User> userList = [];

  int? count;
  String? errorMessage;
  UserViewModel({ required UserFirebase userFirebase}) : _userFirebase = userFirebase;

  Future<void> addUser(Map<String, dynamic> u) async {
    try {
      final User user = await _userFirebase.addUser(u);
      userList.add(user);
      notifyListeners();
    } on Exception catch (e) {
      errorMessage = 'Problem occured $e';
    }
    notifyListeners();
  }

  Future<void> getUsers() async {
    try {
       var list = await _userFirebase.getUsers();
       if(list.length > 0) {
         userList.clear();
         for(var u in list) {
           userList.add(u);
         }
         notifyListeners();
       }
    } on Exception catch (e) {
      print("error in get UserVM: $e");
    }
  }

  //
  // void _updateUser(User u) async {
  //   await userFirebase.updateUser(u.id, u.toJson());
  // }
  //
  // void _deleteUser(User u) async {
  //   await userFirebase.deleteUser(u.id);
  // }

}