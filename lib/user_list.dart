import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myevent/database/api.dart';
import 'package:http/http.dart' as http;
import 'package:myevent/event/card_event_order.dart';
import 'package:myevent/model/eventt.dart';
import 'package:myevent/model/order.dart';

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

List<Order> eventList = [];

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 10, right: 0, top: 5, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // Hanya memperbolehkan satu kategori yang dipilih pada satu waktu
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
                      color:
                          _isSelected[index] ? Color(0xFF512E67) : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: !_isSelected[index]
                          ? Border.all(color: Color(0xFF512E67), width: 1.0)
                          : null,
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: _isSelected[index] ? Colors.white : Colors.black,
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
                Order event = eventList[index];
                return CardEventOrder(order: event);
              },
            ),
          )
        ],
      ),
    );
  }
}
