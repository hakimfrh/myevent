import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent/services/api.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _stepOneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _stepTwoKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _stepThreeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _stepFourKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _pass1Controller = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();

  int _currentStep = 0;
  String email = '';
  String errorEmail = '';
  String errorOtp = '';
  String errorPass = '';
  bool isButtonActive = true;

  void _validateStep() async {
    if (!isButtonActive) return;
    isButtonActive = false;
    if (_currentStep == 0) {
      if (_stepOneKey.currentState!.validate()) {
        _sendCode();
      }
    } else if (_currentStep == 1) {
      if (_stepTwoKey.currentState!.validate()) {
        _verifyCode();
      }
    } else if (_currentStep == 2) {
      if (_stepThreeKey.currentState!.validate()) {
        _resetPassword();
      }
    } else {
      if (_stepFourKey.currentState!.validate()) {
        Get.offNamed('/login');
      }
    }
  }

  void _sendCode() async {
    email = _emailController.text;
    var response = await http.get(Uri.parse("${Api.urlSendCode}?email=$email"));
    if (response.statusCode == 200) {
      // Map<String, dynamic> json = jsonDecode(response.body);
      setState(() {
        _currentStep++;
      });
    } else {
      // Map<String, dynamic> json = jsonDecode(response.body);
      setState(() {
        errorEmail = 'Email tidak ditemukan';
      });
      _stepOneKey.currentState!.validate();
    }
    isButtonActive = true;
  }

  void _verifyCode() async {
    String otp = _otpController.text;
    var response = await http
        .get(Uri.parse("${Api.urlvalidateCode}?email=$email&code=$otp"));
    if (response.statusCode == 200) {
      // Map<String, dynamic> json = jsonDecode(response.body);
      setState(() {
        _currentStep++;
      });
    } else {
      // Map<String, dynamic> json = jsonDecode(response.body);
      setState(() {
        errorOtp = 'Kode salah atau kadaluarsa. Kembali dan coba lagi';
      });
      _stepTwoKey.currentState!.validate();
    }
    isButtonActive = true;
  }

  void _resetPassword() async {
    String otp = _otpController.text;
    String password = _pass2Controller.text;
    var response = await http.get(Uri.parse(
        "${Api.urlvalidateCode}?email=$email&code=$otp&new_password=$password"));
    if (response.statusCode == 200) {
      // Map<String, dynamic> json = jsonDecode(response.body);
      setState(() {
        _currentStep++;
      });
    } else {
      Map<String, dynamic> json = jsonDecode(response.body);
      String errorMessage = json['message'];
      if (errorMessage.contains('unknown')) {
        setState(() {
          errorPass = 'Kode kadaluarsa. Kembali dan coba lagi';
        });
        _stepThreeKey.currentState!.validate();
      }
    }
    isButtonActive = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/logo.png',
              width: 100,
              height: 40,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 0.0),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(4.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: _currentStep == 0
                      ? _buildStepOne()
                      : _currentStep == 1
                          ? _buildStepTwo()
                          : _currentStep == 2
                              ? _buildStepThree()
                              : _buildStepFour(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_currentStep != 3 &&
                        _currentStep !=
                            2) // Tampilkan tombol kembali jika bukan langkah terakhir atau kedua
                      Flexible(
                        child: ElevatedButton(
                          onPressed: _currentStep > 0
                              ? () {
                                  setState(() {
                                    _currentStep--;
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: _currentStep > 0
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 1.0,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Ink(
                            child: Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  'Kembali',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (_currentStep != 3 && _currentStep != 2)
                      const SizedBox(width: 10), // Spacer between buttons
                    Flexible(
                      child: ElevatedButton(
                        onPressed:
                            _validateStep, // Validasi langkah jika bukan langkah terakhir
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6699), Color(0xFF512E67)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                _currentStep == 0
                                    ? 'Selanjutnya'
                                    : _currentStep == 3
                                        ? 'Login' // Ganti teks menjadi "Login" di langkah terakhir
                                        : 'Selesai', // Ganti teks menjadi "Selesai" di langkah kedua
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepOne() {
    return Form(
      key: _stepOneKey,
      child: Column(
        children: [
          Image.asset(
            'images/fpassimg.png',
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: 10.0,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Masukkan dan cek Email untuk kode OTP",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Ex : admin@gmail.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.email_outlined),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            onChanged: (value) {
              errorEmail = '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Email';
              } else if (errorEmail.isNotEmpty) {
                return errorEmail;
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

  Widget _buildStepTwo() {
    return Form(
      key: _stepTwoKey,
      child: Column(
        children: [
          Image.asset(
            'images/fpassOTP.png',
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: 10.0,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Masukkan Kode OTP",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _otpController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.0), // Padding vertikal
              labelStyle: TextStyle(fontSize: 18.0), // Font size label
              // Memastikan teks label (judul) selalu berada di tengah
              alignLabelWithHint: true,
            ),
            textAlign: TextAlign.center, // Teks di tengah
            style: TextStyle(fontSize: 18.0), // Font size input
            onChanged: (value) {
              errorOtp = '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Kode OTP';
              } else if (errorOtp.isNotEmpty) {
                return errorOtp;
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

  Widget _buildStepThree() {
    return Form(
      key: _stepThreeKey,
      child: Column(
        children: [
          Image.asset(
            'images/fpassreset.png',
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: 10.0,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Reset Password",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: _pass1Controller,
            decoration: InputDecoration(
              labelText: 'Masukkan Password Baru',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.password),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Password Baru';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: _pass2Controller,
            decoration: InputDecoration(
              labelText: 'Masukkan Password Lagi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.key),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            onChanged: (value) {
              errorPass = '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Password Lagi';
              } else if (value != _pass1Controller.text) {
                return 'Password tidak sama';
              } else if (errorPass.isNotEmpty) {
                return errorPass;
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

  Widget _buildStepFour() {
    return Form(
      key: _stepFourKey,
      child: Column(
        children: [
          Image.asset(
            'images/fpsucc.png',
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: 10.0,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Password Berhasil Di Reset",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
