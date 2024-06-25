import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent/model/user.dart';
import 'package:myevent/services/api.dart';
import 'package:myevent/services/user_controller.dart';
import 'package:myevent/ubahpassword.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final _editUserFormKey = GlobalKey<FormState>();

class _EditProfileState extends State<EditProfile> {
  User user = Get.arguments as User;

  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _namaPerusahaanController =
      TextEditingController();
  final TextEditingController _deskripsiPerusahaanController =
      TextEditingController();
  final TextEditingController _alamatPerusahaanController =
      TextEditingController();
  final TextEditingController _nomorTelpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaLengkapController.text = user.name ?? '';
    _namaPerusahaanController.text = user.businessName;
    _deskripsiPerusahaanController.text = user.businessDescription ?? '';
    _alamatPerusahaanController.text = user.businessLocation;
    _nomorTelpController.text = user.phone;
    _emailController.text = user.email;
    _usernameController.text = user.username ?? '';
  }

  void updateuser() async {
    User userUpdate = User(
      id: user.id,
      name: _namaLengkapController.text,
      email: _emailController.text,
      phone: _nomorTelpController.text,
      username: _usernameController.text,
      businessName: _namaPerusahaanController.text,
      businessDescription: _deskripsiPerusahaanController.text,
      businessLocation: _alamatPerusahaanController.text,
    );

    try {
      // Convert JSON data to form-data format
      var userMap = userUpdate.toMap();
      var formData = <String, String>{};
      userMap.forEach((key, value) {
        formData[key] = value.toString();
      });

      var response =
          await http.post(Uri.parse(Api.urlUpdateUser), body: formData);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        User user = User.fromMap(json["user"]);
        UserController().user = user;

        // Request successful, parse the response body
        // _showAlertLogout(response.statusCode.toString(), response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User Berhasil Diupdate.")));
        Get.offNamed('/dashboard');
      } else {
        // Request failed, handle error
        Map<String, dynamic> json = jsonDecode(response.body);
      }
    } catch (e) {
      if (e is SocketException) {
        // Handle socket connection error
        // _showAlertLogout("ERROR", e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _editUserFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'EDIT PROFILE ',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Nama Lengkap : ',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _namaLengkapController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.person),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Nama Lengkap';
                              } else if (!value
                                  .contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                                return 'Nama Lengkap Tidak Valid';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const Text(
                            'Nama Perusahaan : ',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _namaPerusahaanController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Nama Perusahaan',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.business),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Nama Perusahaan';
                              } else if (!value
                                  .contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                                return 'Nama Perusahaan Tidak Valid';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Deskripsi Perusahaan : ',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _deskripsiPerusahaanController,
                            decoration: InputDecoration(
                              labelText: 'Deskripsi Perusahaan',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.description),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 28.0,
                                  horizontal: 12.0), // Added padding
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Deskripsi Perusahaan';
                              } else if (!value
                                  .contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                                return 'Deskripsi harus di isi';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Alamat Perusahaan : ',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _alamatPerusahaanController,
                            decoration: InputDecoration(
                              labelText: 'Alamat perusahaan',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.location_on),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 28.0,
                                  horizontal: 12.0), // Added padding
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Alamat';
                              } else if (!value
                                  .contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                                return 'Alamat Tidak Valid';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'No Telp : ',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _nomorTelpController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'No Telp',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.phone),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan No Telp';
                              } else if (!value
                                  .contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                                return 'No Telp Tidak Valid';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Email : ',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.email),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Email';
                              } else if (!value
                                  .contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                                return 'Email Tidak Valid';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Username : ',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Username';
                              } else if (!value
                                  .contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                                return 'Username Tidak Valid';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // makeOrder();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UbahPassword()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 255, 255, 255), // Warna ungu
                              fixedSize: const Size(
                                  370, 50), // Lebar dan tinggi tombol
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Radius sudut
                              ),
                            ),
                            child: const Text('Reset Password',
                                style: TextStyle(color: Colors.black)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              updateuser();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF512E67), // Warna ungu
                              fixedSize: const Size(
                                  370, 50), // Lebar dan tinggi tombol
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Radius sudut
                              ),
                            ),
                            child: const Text('Simpan',
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 24.0),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Ingin Logout? ",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                TextSpan(
                                  text: "Logout",
                                  style: const TextStyle(
                                    color: Colors
                                        .blue, // Ubah warna teks "Daftar" sesuai kebutuhan
                                    fontWeight: FontWeight
                                        .bold, // Contoh: Menjadikan teks "Daftar" tebal
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      UserController().logout();
                                      Get.offAllNamed('/login');

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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
