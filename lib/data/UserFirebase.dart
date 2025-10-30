import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giuaky/data/User.dart';

class UserFirebase {
  var db = FirebaseFirestore.instance;

  Future<User> addUser(Map<String, dynamic> u) async {
    try {

      final docRef = await db.collection("Users").add(u);
      return User.fromJson(u, docRef.id);
    } catch (e) {
      throw("Lỗi khi thêm user: $e");
    }
  }

  Future<List<User>> getUsers() async {
    try {
      var list = <User>[];
      final querySnapshot = await db.collection("Users").get();
      print("Successfully completed");

      for (var docSnapshot in querySnapshot.docs) {
        list.add(User.fromJson(docSnapshot.data(), docSnapshot.id));
      }
      return list;

    } catch (e) {
      print("Lỗi khi thêm user: $e");
      return List.empty();
    }
  }


  Future<void> updateUser(String id, Map<String, dynamic> u) async {
    try {
      await db.collection("Users").doc(id).set(u);

    } catch (e) {
      print("Lỗi khi thêm user: $e");
      throw(e);
    }
  }
  Future<void> deleteUser(String id) async {
    try {
      await db.collection("Users").doc(id).delete().then(
            (doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );
    } catch (e) {
      print("Lỗi khi xóa user: $e");
      return null;
    }
  }

}