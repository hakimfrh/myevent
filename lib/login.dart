import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myevent/dashboard.dart';
import 'package:myevent/model/user.dart';
import 'package:myevent/navigation_drawer.dart';
import 'package:myevent/register.dart';
import 'package:myevent/database/sql_user.dart';

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
                    onPressed: () {
                      // Aksi ketika tombol ditekan
                    },
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()),
                            );
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

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      final dbUser = UserDatabase();
      await dbUser.initializeDatabase();
      User user = await dbUser.login(email, password);

      if (!mounted) return;
      if (user.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User tidak ditemukan || email atau password salah'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
            settings: RouteSettings(arguments: user), ////data => argumen
          ),
        );
      }
    }
  }
}
