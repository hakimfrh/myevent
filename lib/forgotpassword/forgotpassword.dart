import 'package:flutter/material.dart';
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

  bool _isPasswordHidden = true;
  bool _isPasswordHidden2 = true;
  int _currentStep = 0;
  String? _emailError;

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
                        onPressed: _currentStep ==
                                3 // Navigasi ke halaman login jika langkah terakhir
                            ? () {
                                // Tambahkan logika untuk menuju halaman login
                              }
                            : _validateStep, // Validasi langkah jika bukan langkah terakhir
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Email';
              }
              return null;
            },
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
            //controller: _companyNameController,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Kode OTP';
              }
              return null;
            },
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
            //controller: _companyNameController,
            decoration: InputDecoration(
              labelText: 'Masukkan Password Lama',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.password),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Password Lama';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            //controller: _companyNameController,
            decoration: InputDecoration(
              labelText: 'Masukkan Password Baru',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.key),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Password Baru';
              }
              return null;
            },
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
  final TextEditingController _emailController = TextEditingController();

  void _validateStep() async {
    if (_currentStep == 0) {
      if (_stepOneKey.currentState!.validate()) {
        _sendCode();
        setState(() {
          _currentStep++;
        });
      }
    } else if (_currentStep == 1) {
      if (_stepTwoKey.currentState!.validate()) {
        setState(() {
          _currentStep++;
        });
      }
    } else if (_currentStep == 2) {
      if (_stepThreeKey.currentState!.validate()) {
        setState(() {
          _currentStep++;
        });
      }
    } else {
      if (_stepFourKey.currentState!.validate()) {
        _register();
      }
    }
  }

  void _register() async {
    // Your registration logic here
    // Example: sending data to an API endpoint
  }

  void _sendCode() async{
    String email = _emailController.text;
    var response = await http.get(Uri.parse("${Api.urlSendCode}?email=$email"));
  }
}
