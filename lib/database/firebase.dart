import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseController {
  static Future<User?> loginWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();
    final googleAuth = await googleAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    return userCredential.user;
  }

  static Future<String> getId() async{
     final currentUser = FirebaseAuth.instance.currentUser;
      final uid = currentUser?.uid;
      return uid??"";
  }
  static Future<String> getEmail() async{
     final currentUser = FirebaseAuth.instance.currentUser;
      final email = currentUser?.email;
      return email??"";
  }
  static Future<String> getPhone() async{
     final currentUser = FirebaseAuth.instance.currentUser;
      final phone = currentUser?.phoneNumber;
      return phone??"";
  }
  static Future<List<UserInfo>?> getInfo() async{
     final currentUser = FirebaseAuth.instance.currentUser;
      final phone = currentUser?.providerData;
      return phone;
  }


  static void logout() async{
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
}
