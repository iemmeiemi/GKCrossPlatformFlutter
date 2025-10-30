import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:giuaky/data/User.dart';
import 'package:giuaky/data/UserFirebase.dart';
import 'package:giuaky/data/others/cloudinary.dart';

class UserViewModel extends ChangeNotifier{
  late final UserFirebase _userFirebase;
  late List<User> users = [];
  late List<User> userList = [];
  late List<User> filteredUserList = [];
  late String searchQuery = '';

  int? count;
  String? errorMessage;
  UserViewModel({ required UserFirebase userFirebase}) : _userFirebase = userFirebase;

  Future<void> fetchUsers() async {
    try {
      if(searchQuery.length > 0) {
        print("d");
        filterUsers();
      } else {
        userList = await _userFirebase.getUsers();
        filteredUserList = userList;

      }
      notifyListeners();
    } catch (e) {
      errorMessage = "Lỗi khi tải danh sách người dùng: $e";
      notifyListeners();
    }
  }

  Future<void> addUser(Map<String, dynamic> u) async {
    try {
      File file = new File(u['image']);
      u['image'] = await  CloudinaryServices().uploadImage(file) as String;
      await _userFirebase.addUser(u);
      fetchUsers();
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


  Future<void> updateUser(String id, Map<String, String> u) async {
    try {
      // File file = new File(u['image']!);
      // u['image'] = await  CloudinaryServices().uploadImage(file) as String;
      await _userFirebase.updateUser(id, u);
      fetchUsers();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void deleteUser(String id) async {
    await _userFirebase.deleteUser(id);
    fetchUsers();
  }

  void filterUsers() {
    filteredUserList  = userList.where((user) {
      final query = searchQuery.toLowerCase();

      final matchesName = user.username.toLowerCase().contains(query);
      final matchesEmail = user.email.toLowerCase().contains(query);

      return matchesName || matchesEmail;
    }).toList();
    notifyListeners();
  }

}