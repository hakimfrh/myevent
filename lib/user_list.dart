import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myevent/database/api.dart';
import 'package:http/http.dart' as http;
import 'package:myevent/event/card_event.dart';
import 'package:myevent/model/event.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

List<bool> _isSelected = [false, false, false, false];
final List<String> categories = [
  'Semua',
  'Ditolak',
  'Menunggu Pembayaran',
  'Selesai'
];

List<Eventt> eventList = [
  Eventt(
      idEvent: '123123',
      status: 'Selesai',
      tanggal: '28 Februari 2023',
      namaEvent: 'Sunday Services',
      deskripsiEvent:
          'Festival yang menggabungkan seni, musik, dan aktivitas hijau untuk mempromosikan kesadaran lingkungan dan kreativitas.',
      hargaMin: '250.000',
      hargaMax: '500.000',
      lokasi: 'jember',
      noWa: '12308128123',
      cover: 'logo.png'),
  Eventt(
      idEvent: '456456',
      status: 'Menunggu Pembayaran',
      tanggal: '40 Februari 2023',
      namaEvent: 'Summer Van Tour',
      deskripsiEvent:
          'Konser hura hura bersama artis terkenal. Dimeriahkan oleh Coldplay, Ed-Shetan, dan Puyung Teduh.',
      hargaMin: '300.000',
      hargaMax: '800.000',
      lokasi: 'Jakarta',
      noWa: '12308120123',
      cover: 'logo.png'),
  Eventt(
      idEvent: '789789',
      status: 'Ditolak',
      tanggal: '10 Februari 2023',
      namaEvent: 'Black Parade',
      deskripsiEvent: 'Ajang festival peringatan hari hitam sedunia',
      hargaMin: '300.000',
      hargaMax: '800.000',
      lokasi: 'Malang',
      noWa: '12308120123',
      cover: 'logo.png'),
];

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 10, right: 0, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // Only allow one category to be selected at a time
                      for (int i = 0; i < _isSelected.length; i++) {
                        _isSelected[i] = i == index;
                      }
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: _isSelected[index] ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: eventList.length, // Jumlah total item dalam daftar
              itemBuilder: (context, index) {
                Eventt event = eventList[index];
                return CardEvent(event: event);
              },
            ),
          )
        ],
      ),
    );
  }
}
