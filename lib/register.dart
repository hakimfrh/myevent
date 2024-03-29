import 'package:flutter/material.dart';
import 'package:myevent/login.dart';
import 'package:myevent/model/user.dart';
import 'package:myevent/database/sql_user.dart';

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
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep--; // Kembali ke tahap sebelumnya
                  });
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false,
                  ); // Kembali ke halaman sebelumnya jika sudah pada tahap pertama
                }
              },
            ),
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
              }  else {
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

  void _register() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Menambakhan User")));

    //inisialisasi variabel dari controller.
    String nama = _fullNameController.text;
    String alamat = _locationController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String nomor = _phoneNumberController.text;
    String namaPerusahaan = _companyNameController.text;
    String lokasi = _locationController.text;
    String deskipsiPerusahaan = _descriptionController.text;

//objek
    User user = User(
      nama: nama,
      alamat: alamat,
      username: username,
      password: password,
      email: email,
      namaPerusahaan: namaPerusahaan,
      deskipsiPerusahaan: deskipsiPerusahaan,
      nomor: nomor,
      lokasi: lokasi,
    );
    final dbUser = UserDatabase();
    await dbUser.initializeDatabase();
    
    if (await dbUser.register(user)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User Berhasil Ditambahkan")));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false,
      );
    }else{
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username sudah ada")));
    }
  }
}
