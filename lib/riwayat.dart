import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:myevent/event/card_event_order.dart';
import 'package:myevent/model/eventt.dart';
import 'package:myevent/model/order.dart';
import 'package:myevent/model/user.dart';
import 'package:myevent/services/user_controller.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

// List<bool> _isSelected = [false, false, false, false];
final List<String> categories = [
  'Semua',
  'validasi',
  'ditolak',
  'diterima',
  'menunggu pembayaran',
  'terverifikasi'
];

final List<String> categoriesName = [
  'Semua',
  'validasi',
  'Ditolak',
  'Menunggu Pembayaran',
  'Verifikasi Pembayaran',
  'Selesai'
];
   
int selectedindex = 0;

List<Order> orderList = [];
User user = UserController().user!;

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    getOrder();
  }

  void getOrder() async {
    print(selectedindex);
    String filters = '';
    if (selectedindex > 0) {
      filters += '&status_order=';
      filters += Uri.encodeComponent(categories[selectedindex]).toLowerCase();
    }
    var response =
        await http.get(Uri.parse('${Api.urlOrder}?user_id=${user.id}$filters'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['order_list'];
      orderList = [];
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> orderMap = data[i];
        // print(orderMap.toString());
        Order order = Order.fromJson(orderMap);
        if (!mounted) return;
        setState(() {
          orderList.add(order);
        });
      }
    } else {
      // Request failed, handle error
    }
  }

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
              children: List.generate(categoriesName.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // Hanya memperbolehkan satu kategori yang dipilih pada satu waktu
                      selectedindex = index;
                      orderList = [];
                      getOrder();
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: selectedindex == index
                          ? Color(0xFF512E67)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: selectedindex != index
                          ? Border.all(color: Color(0xFF512E67), width: 1.0)
                          : null,
                    ),
                    child: Text(
                      categoriesName[index],
                      style: TextStyle(
                        color: selectedindex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orderList.length, // Jumlah total item dalam daftar
              itemBuilder: (context, index) {
                Order event = orderList[index];
                return GestureDetector(
                    onTap: () {
                      Get.toNamed('/pembayaran', arguments: event);
                    },
                    child: CardEventOrder(order: event));
              },
            ),
          )
        ],
      ),
    );
  }
}
