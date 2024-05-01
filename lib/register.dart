import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent/database/api.dart';
import 'package:myevent/model/user.dart';
import 'package:myevent/database/sql_user.dart';
import 'package:http/http.dart' as http;

final _stepOneKey = GlobalKey<FormState>();
final _stepTwoKey = GlobalKey<FormState>();

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   onPressed: () {
            //     if (_currentStep > 0) {
            //       setState(() {
            //         _currentStep--; // Kembali ke tahap sebelumnya
            //       });
            //     } else {
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (context) => const Login()),
            //         (route) => false,
            //       ); // Kembali ke halaman sebelumnya jika sudah pada tahap pertama
            //     }
            //   },
            // ),
            const SizedBox(width: 0), // Add space between back button and image
            Image.asset(
              'images/logo.png', // Replace 'assets/register_logo.png' with your image asset path
              width: 100, // Adjust width as needed
              height: 40, // Adjust height as needed
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Daftarkan \nAkun Baru!",
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
                  "Registrasi Untuk Melanjutkan ke Aplikasi!",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 28.0),
              // Tampilkan form sesuai dengan tahapan yang sedang aktif
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: _currentStep == 0 ? _buildStepOne() : _buildStepTwo(),
              ),
              const SizedBox(height: 20),
              // Tombol untuk beralih ke tahapan berikutnya
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
                  onPressed: _validateStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      _currentStep == 0 ? 'Selanjutnya' : 'Selesai',
                      style: const TextStyle(
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
      ),
    );
  }

  // Widget untuk tahapan pertama pengisian form
  Widget _buildStepOne() {
    return Form(
      key: _stepOneKey,
      // Form untuk tahapan pertama
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed
              child: const Text(
                "Nama Lengkap",
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
            controller: _fullNameController,
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.person),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Nama Lengkap';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(
              height: 14), // Menambahkan jarak antara dua input field
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed
              child: const Text(
                "Username",
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
            controller: _usernameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.account_box),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan username';
              } else if (!value.contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                return 'Username Tidak Valid';
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(
              height: 14), // Menambahkan jarak antara dua input field
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed
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
                return 'Masukkan Password';
              } else if (value.length < 8) {
                return 'Password Minimal 8 Karakter';
              } else if (!value.contains(RegExp(r'[a-zA-Z]')) ||
                  !value.contains(RegExp(r'[0-9]'))) {
                return 'Wajib Terdapat Huruf Dan Angka';
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(
              height: 14), // Menambahkan jarak antara dua input field
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed
              child: const Text(
                "Re-Password",
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
            controller: _rePasswordController,
            decoration: InputDecoration(
              labelText: 'Re-Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.key),
              suffixIcon: IconButton(
                icon: Icon(_isPasswordHidden2
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: _togglePasswordVisibility2,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            obscureText: _isPasswordHidden2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ketik Ulang Password';
              } else if (value != _passwordController.text) {
                return 'Password tidak sama';
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),

          const SizedBox(
              height: 14), // Menambahkan jarak antara dua input field
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed
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
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.email),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              errorText: _emailError,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan email';
              } else if (!value.contains('@')) {
                return 'Masukkann email yang valid';
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(
              height: 14), // Menambahkan jarak antara dua input field
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed
              child: const Text(
                "No Telepon",
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
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'No Telepon',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.phone),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan nomor telepon';
              } else if (value.length <= 8) {
                return 'Masukkan nomor telepon yang valid';
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
    );
  }

  // Widget untuk tahapan kedua pengisian form
  Widget _buildStepTwo() {
    return Form(
      // Form untuk tahapan kedua
      key: _stepTwoKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed
              child: const Text(
                "Nama Perusahaan/Bisnis/UKM",
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
            controller: _companyNameController,
            decoration: InputDecoration(
              labelText: 'Nama Perusahaan/Bisnis/UKM',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.home),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan nama perusahaan';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed
              child: const Text(
                "Lokasi Perusahaan/Bisinis/UKM",
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
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Lokasi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.location_pin),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan lokasi';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(4.0), // Adjust margin as needed

              child: const Text(
                "Deskripsi Perusahaan/Bisnis/UKM",
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
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Deskripsi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.description),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 28.0, horizontal: 12.0), // Added padding
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan deskripsi Perusahaan';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  //BACKEND HERE !!!

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isPasswordHidden2 = true;
  int _currentStep = 0;
  String ? _emailError;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _isPasswordHidden2 = !_isPasswordHidden2;
    });
  }

  void _validateStep() {
    setState(() {
      if (_currentStep == 0) {
        if (_stepOneKey.currentState!.validate()) {
          _currentStep++;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Periksa Kembali Data")));
        }
      } else {
        if (_stepTwoKey.currentState!.validate()) {
          _register();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Periksa Kembali Data")));
        }
      }
    });
  }

  // void _register() async {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text("Menambakhan User")));

  //inisialisasi variabel dari controller.
  // String nama = _fullNameController.text;
  // String username = _usernameController.text;
  // String password = _passwordController.text;
  // String email = _emailController.text;
  // String nomor = _phoneNumberController.text;
  // String namaPerusahaan = _companyNameController.text;
  // String lokasi = _locationController.text;
  // String deskipsiPerusahaan = _descriptionController.text;

//objek
//     User user = User(
//       name: _fullNameController.text,
//       email: _emailController.text,
//       phone: _phoneNumberController.text,
//       username: _usernameController.text,
//       password: _passwordController.text,
//       businessName: _companyNameController.text,
//       businessDescription: _descriptionController.text,
//       businessLocation: _locationController.text,
//     );
//     final dbUser = UserDatabase();
//     await dbUser.initializeDatabase();

//     if (await dbUser.register(user)) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("User Berhasil Ditambahkan")));
//       // Navigator.pushAndRemoveUntil(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => const Login()),
//       //   (route) => false,
//       // );
//       Get.back();
//     }else{
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Username sudah ada")));
//     }
//   }
  void _register() async {
    User user = User(
      name: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneNumberController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      businessName: _companyNameController.text,
      businessDescription: _descriptionController.text,
      businessLocation: _locationController.text,
    );

    try {
      // Convert JSON data to form-data format
      var userMap = user.toMap();
      var formData = <String, String>{};
      userMap.forEach((key, value) {
        formData[key] = value.toString();
      });

      var response =
          await http.post(Uri.parse(Api.urlRegister), body: formData);
      if (response.statusCode == 200) {
        // Request successful, parse the response body
        _showAlertLogout(
            response.statusCode.toString(), response.body.toString());
      } else {
        // Request failed, handle error
        Map<String, dynamic> json = jsonDecode(response.body);
        if (json['message'].toString().contains("Username")) {
          setState(() {
            // _stepOneKey.currentState?.setState(() {
            //   _stepOneKey.currentState?.=
            //       'Field 1 is required';
            // });
          });
        }
        if (json['message'].toString().contains("Email")) {
          setState(() {
        _emailError = 'Email telah digunakan';
      });
        }
        if (json['message'].toString().contains("Password")) {}
        
      }
    } catch (e) {
      if (e is SocketException) {
        // Handle socket connection error
        _showAlertLogout("ERROR", e.toString());
      }
    }
  }

  Future<void> _checkEmailAvailability(String email) async {
    // Kirim permintaan HTTP ke API Anda
    final response = await http.get(Uri.parse('${Api.urlRegister}?email=$email'));

    if (response.statusCode == 200) {
      // Jika permintaan berhasil, cek apakah email telah digunakan
      final jsonData = jsonDecode(response.body);
      final emailExists = jsonData['exists'];

      setState(() {
        _emailError = emailExists ? 'Email telah digunakan' : null;
      });
    } else {
      // Jika permintaan gagal, tangani kesalahan sesuai kebutuhan Anda
      setState(() {
        _emailError = 'Gagal memeriksa email';
      });
    }
  }

  Future<void> _showAlertLogout(String title, String text) async {
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
}
