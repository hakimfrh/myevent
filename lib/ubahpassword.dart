import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myevent/services/api.dart';
import 'package:myevent/services/user_controller.dart';

class UbahPassword extends StatefulWidget {
  const UbahPassword({super.key});

  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

final _formKey = GlobalKey<FormState>();

class _UbahPasswordState extends State<UbahPassword> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _rePassword = TextEditingController();
  String errorPassword = '';

  void updatepassword() async {
    var formData = <String, dynamic>{};
    formData['id'] = UserController().user!.id.toString();
    formData['current_password'] = _oldPassword.text;
    formData['new_password'] = _rePassword.text;

    var response =
        await http.post(Uri.parse(Api.urlUpdatePassword), body: formData);
    if (response.statusCode == 200) {
      // Request successful, parse the response body
      // _showAlertLogout(response.statusCode.toString(), response.body.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password berhasil diubah")));
      Get.offNamed('/dashboard');
    } else {
      Map<String, dynamic> json = jsonDecode(response.body);
      String message = json['message'].toString().toLowerCase();
      if (message.contains('password')) {
        setState(() {
          errorPassword = 'Password Salah';
        });
        _formKey.currentState!.validate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password Lama : ',
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _oldPassword,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Password Lama',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: const Icon(Icons.password),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    onChanged: (value) {
                      errorPassword = '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Password Lama';
                      } else if (!value.contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                        return 'Password Lama Tidak Valid';
                      } else if (errorPassword.isNotEmpty) {
                        return errorPassword;
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Password Baru : ',
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _newPassword,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Password Baru',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Password';
                      } else if (!value.contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                        return 'Password Baru Tidak Valid';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Re Password : ',
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _rePassword,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Re Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: const Icon(Icons.lock_reset),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Password Lagi';
                      } else if (!value.contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                        return 'Password Tidak Valid';
                      } else if (value != _newPassword.text) {
                        return 'Password Tidak Sama';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updatepassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF512E67), // Warna ungu
                      fixedSize: const Size(370, 50), // Lebar dan tinggi tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Radius sudut
                      ),
                    ),
                    child: const Text('Simpan',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
