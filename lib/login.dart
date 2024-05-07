import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth_platform_interface/src/user_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent/database/api.dart';
import 'package:myevent/database/firebase.dart';
import 'package:myevent/model/user.dart';
// import 'package:myevent/database/sql_user.dart';
import 'package:http/http.dart' as http;

final _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          // Tambahkan SingleChildScrollView di sini
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "images/logo.png", // Path atau lokasi dari gambar
                    width: 80, // Lebar gambar
                  ),
                ),

                const SizedBox(height: 16.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selamat \nDatang!",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 54.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Halo Silahkan Melakukan login / Register",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 28.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(
                              4.0), // Adjust margin as needed
                          child: const Text(
                            "Email",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.email),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Email';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(
                              4.0), // Adjust margin as needed
                          child: const Text(
                            "Password",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: _togglePasswordVisibility,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        obscureText: _isPasswordHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan password';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6699), Color(0xFF512E67)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Atau',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        height: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  height: 50.0, // Atur tinggi tombol di sini
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0), // Bentuk tombol
                    border: Border.all(
                      color: Colors.black, // Warna garis pinggir
                      width: 1.0, // Ketebalan garis pinggir
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: continueWithGoogle,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(
                          255, 255, 255, 255), // Warna teks tombol
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Bentuk tombol
                      ),
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.max, // Tombol akan melebar penuh
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Mengatur teks ke tengah tombol
                      children: <Widget>[
                        Image.asset(
                          'images/google.png', // Lokasi file logo Google
                          height: 36.0, // Tinggi logo
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 8.0), // Jarak antara logo dan teks
                          child: Text(
                            'Sign in with Google', // Teks tombol
                            style: TextStyle(
                              fontSize: 16.0, // Ukuran teks
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Don't have an account link
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Tidak Punya akun? ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      TextSpan(
                        text: "Daftar",
                        style: const TextStyle(
                          color: Colors
                              .blue, // Ubah warna teks "Daftar" sesuai kebutuhan
                          fontWeight: FontWeight
                              .bold, // Contoh: Menjadikan teks "Daftar" tebal
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Implementasi logika ketika "Daftar" ditekan
                            Get.toNamed('/register');

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const Register()),
                            // );
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Don't have an account link
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Lupa Password? ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      TextSpan(
                        text: "Klik Disini",
                        style: const TextStyle(
                          color: Colors
                              .blue, // Ubah warna teks "Daftar" sesuai kebutuhan
                          fontWeight: FontWeight
                              .bold, // Contoh: Menjadikan teks "Daftar" tebal
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Implementasi logika ketika "Daftar" ditekan
                            Get.toNamed('/forgotpassword');

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const Register()),
                            // );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //BACKEND HERE
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  // void _login() async {
  //   if (_formKey.currentState!.validate()) {
  //     String email = _emailController.text;
  //     String password = _passwordController.text;
  //     final dbUser = UserDatabase();
  //     await dbUser.initializeDatabase();
  //     User user = await dbUser.login(email, password);

  //     if (!mounted) return;
  //     if (user.id == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('User tidak ditemukan || email atau password salah'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     } else {
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(
  //       //     builder: (context) => const Dashboard(),
  //       //     settings: RouteSettings(arguments: user), ////data => argumen
  //       //   ),
  //       // );

  //       Get.offNamed('/dashboard', arguments: user);
  //     }
  //   }
  // }
  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        var response = await http
            .get(Uri.parse("${Api.urlLogin}?login=$email&password=$password"));
        Map<String, dynamic> json = jsonDecode(response.body);
        if (response.statusCode == 200) {
          // Request successful, parse the response body
          User user = User.fromMap(json["user"]);
          Get.offNamed('/dashboard', arguments: user);
        } else {
          // Request failed, handle error
          _showAlertDialog(
              "ERROR CODE ${response.statusCode}", json["message"].toString());
        }
      } catch (e) {
        // Handle socket connection error
        _showAlertDialog("ERROR", e.toString());
      }
    }
  }

  Future<void> _showAlertDialog(String title, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void continueWithGoogle() async {
    FirebaseController.logout();
    final user = await FirebaseController.loginWithGoogle();
    if (user != null) {
      String uid = await FirebaseController.getId();
      String email = await FirebaseController.getEmail();

      // String phone = await FirebaseController.getPhone();
      // List<UserInfo>? listInfo = await FirebaseController.getInfo();
      // String info = listInfo.toString();
      // String text = "UID: $uid\nemail: $email\nphone: $phone\n info: $info";
      // _showAlertDialog("Firebase Login", text);


      try {
        var response = await http.get(Uri.parse("${Api.urlContinueGoogle}?email=$email&firebase_id=$uid"));
        Map<String, dynamic> json = jsonDecode(response.body);
        if (response.statusCode == 200) {
          // Request successful, parse the response body
          User user = User.fromMap(json["user"]);
          Get.offNamed('/dashboard', arguments: user);
        } else {
          // Request failed, handle error
          _showAlertDialog(
              "ERROR CODE ${response.statusCode}", json["message"].toString());
        }
      } catch (e) {
        // Handle socket connection error
        _showAlertDialog("ERROR", e.toString());
      }
    }
  }
}
