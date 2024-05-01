import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myevent/database/api.dart';
import 'package:http/http.dart' as http;

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          return ListTile(
            title: Text(
                user['name']), // Disesuaikan dengan struktur data user dari API
            subtitle: Text(user[
                'email']), // Disesuaikan dengan struktur data user dari API
            // Tambahan informasi atau aksi lainnya
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Aksi untuk menghapus user
              },
            ),
          );
        },
      ),
    );
  }

  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers(); // Memuat data user saat halaman pertama kali dibuka
  }

  Future<void> _loadUsers() async {
    var url = Uri.parse(
        Api.urlUserList); // Menggunakan URL API untuk mengambil data user
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data != null && data['user'] != null) {
        setState(() {
          users = data['user']; // Mengambil daftar data user dari API
        });
      }
    } else {
      // Handle jika gagal mengambil data dari API
      print('Failed to load users');
    }
  }
}
