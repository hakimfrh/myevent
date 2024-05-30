import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth_platform_interface/src/user_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myevent/database/api.dart';
import 'package:myevent/database/firebase.dart';
import 'package:myevent/model/eventt.dart';
import 'package:myevent/model/user.dart';
// import 'package:myevent/database/sql_user.dart';
import 'package:http/http.dart' as http;
import 'package:myevent/model/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

final _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription? _sub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserController().clearUser();
    // FirebaseController.logout();
    autoLogin().then((v) {
      initUniLinks();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
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
          UserController().user = user;
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('login', email);
          await prefs.setString('pass', password);

          Get.offNamed('/dashboard');
          // Get.offNamed('/dashboard', arguments: user);
        } else {
          if (json['message'].toString().toLowerCase().contains('user')) {
            _showAlertDialog("Email tidak terdaftar","Email yang anda gunakan belum didaftaran. Silahkan daftarkan akun anda terlebih dahulu");
            FirebaseController.logout();
            Get.toNamed('/register');
          } else {
            // Request failed, handle error
            _showAlertDialog("ERROR CODE ${response.statusCode}",
                json["message"].toString());
          }
        }
      } catch (e) {
        // Handle socket connection error
        _showAlertDialog("ERROR", e.toString());
      }
    }
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login = prefs.getString('login');
    String? password = prefs.getString('pass');
    if (login != null && password != null) {
      try {
        prefs.getString('name');
        var response = await http
            .get(Uri.parse("${Api.urlLogin}?login=$login&password=$password"));
        Map<String, dynamic> json = jsonDecode(response.body);
        if (response.statusCode == 200) {
          // Request successful, parse the response body
          User user = User.fromMap(json["user"]);
          UserController().user = user;

          Get.offNamed('/dashboard');
          // Get.offNamed('/dashboard', arguments: user);
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

    final currentUser = await FirebaseController.getCurrentUser();
    if (currentUser != null) {
      String uid = await FirebaseController.getId();
      String email = await FirebaseController.getEmail();
      try {
        var response = await http.get(Uri.parse(
            "${Api.urlContinueGoogle}?email=$email&firebase_id=$uid"));
        Map<String, dynamic> json = jsonDecode(response.body);
        if (response.statusCode == 200) {
          // Request successful, parse the response body
          User user = User.fromMap(json["user"]);
          Get.offNamed('/dashboard', arguments: user);
        } else {
          // // Request failed, handle error
          // _showAlertDialog(
          //     "ERROR CODE ${response.statusCode}", json["message"].toString());
        }
      } catch (e) {
        // Handle socket connection error
        // _showAlertDialog("ERROR", e.toString());
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
        var response = await http.get(Uri.parse(
            "${Api.urlContinueGoogle}?email=$email&firebase_id=$uid"));
        Map<String, dynamic> json = jsonDecode(response.body);
        if (response.statusCode == 200) {
          // Request successful, parse the response body
          User user = User.fromMap(json["user"]);
          Get.offNamed('/dashboard', arguments: user);
        } else {
          // Request failed, handle error
          _showAlertDialog(
              "ERROR CODE ${response.statusCode}", json["message"].toString());
          FirebaseController.logout();
        }
      } catch (e) {
        // Handle socket connection error
        _showAlertDialog("ERROR", e.toString());
      }
    }
  }

  Future<void> initUniLinks() async {
    // Handle incoming links
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        List<String> pathSegments = uri.pathSegments;
        if (pathSegments.length == 3 &&
            pathSegments[0] == 'event' &&
            pathSegments[1] == 'detail') {
          String eventId = pathSegments[2];
          // Navigator.pushNamed(context, '/details', arguments: eventId);
          // _showAlertDialog('open from url', eventId);
          getEvent(eventId).then((event) {
            if (event != null) {
              if (UserController().user == null) {
                _showAlertDialog('Anda belum login',
                    'Silahkan login terlebih dahulu untuk menggunakan aplikasi');
              } else {
                Get.toNamed('/event', arguments: event);
              }
            }
          });
        }
      }
    }, onError: (Object err) {
      // Handle error
    });

    // Handle the initial link
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        List<String> pathSegments = initialUri.pathSegments;
        if (pathSegments.length == 3 &&
            pathSegments[0] == 'event' &&
            pathSegments[1] == 'detail') {
          String eventId = pathSegments[2];
          // Navigator.pushNamed(context, '/details', arguments: eventId);
          // _showAlertDialog('open from url', eventId);
          getEvent(eventId).then((event) {
            if (UserController().user == null) {
              _showAlertDialog('Anda belum login',
                  'Silahkan login terlebih dahulu untuk menggunakan aplikasi');
            } else {
              Get.toNamed('/event', arguments: event);
            }
          });
        }
      }
    } on PlatformException {
      // Handle exception
    } on FormatException {
      // Handle exception
    }
  }

  Future<Eventt?> getEvent(String eventId) async {
    var response =
        await http.get(Uri.parse('${Api.urlEventGet}?id_event=$eventId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      Eventt event = Eventt.fromJson(json['event']);
      return event;
    } else {
      // Request failed, handle error
      return null;
    }
  }

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
}
