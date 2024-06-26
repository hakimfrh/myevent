import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myevent/dashboard.dart';
import 'package:myevent/editprofile.dart';
import 'package:myevent/event/detail_event.dart';
import 'package:myevent/firebase_options.dart';
import 'package:myevent/login.dart';
import 'package:myevent/forgotpassword.dart';
import 'package:myevent/search_event.dart';
import 'package:myevent/register.dart';
import 'package:myevent/pembayaran.dart';
import 'package:myevent/riwayat.dart';
import 'package:get/get.dart';
import 'package:myevent/ubahpassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: Login(),
    // );
    return GetMaterialApp(
      // Instead of MaterialApp, use GetMaterialApp
      title: 'Flutter GetX Routing Example',
      debugShowCheckedModeBanner: false,
      // Define initial route
      initialRoute: '/login',
      // Define routes
      getPages: [
        // Example of a named route
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/dashboard', page: () => Dashboard()),
        GetPage(name: '/forgotpassword', page: () => ForgotPassword()),
        GetPage(name: '/event', page: () => Event()),
        GetPage(name: '/listevent', page: () => ListEvent()),
        GetPage(name: '/pembayaran', page: () => Pembayaran()),
        GetPage(name: '/riwayat', page: () => UserList()),
        GetPage(name: '/editprofile', page: () => EditProfile()),
        GetPage(name: '/ubahpassword', page: () => UbahPassword()),
      ],
    );
  }
}
