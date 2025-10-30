import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

const String webClientId = "89020089631-tsn1f1it1kdnp101ig59dn37rarjngdc.apps.googleusercontent.com";


Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  await googleSignIn.initialize(
    serverClientId: webClientId, // <--- Truyền ID tại đây
  );

  final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(idToken: googleAuth?.idToken);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
void getCurrentUser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    print("Email: ${user.email}");
    print("UID: ${user.uid}");
  } else {
    print("Chưa đăng nhập");
  }
}

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut(); // Đăng xuất khỏi Firebase
    print("Đăng xuất thành công!");
  } on Exception catch (e) {
    print(e.toString());
  }
}
