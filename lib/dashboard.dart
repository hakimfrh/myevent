import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent/services/api.dart';
import 'package:myevent/event/detail_event.dart';
import 'package:myevent/getx_state.dart';
import 'package:myevent/event/card_event_order.dart';
import 'package:myevent/model/order.dart';
import 'package:myevent/model/user.dart';
import 'package:myevent/services/user_controller.dart';
import 'package:myevent/search_event.dart';
import 'package:myevent/riwayat.dart';
import 'model/eventt.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
  const Dashboard({super.key});
}

class DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  String location = UserController().cityName ?? 'Klik untuk cari lokasi';

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const ListEvent(),
    const UserList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void refreshLocation() async {
    String result = await UserController().refreshLocation();
    if (result == 'ok') {
      setState(() {
        location = UserController().cityName ?? 'Lokasi tak diketahui';
      });
    } else {
      throw result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/logo.png',
              width: 40, // Add the desired width here
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  location = 'Memuat Lokasi';
                });
                refreshLocation();
              },
              child: Row(
                children: [
                  Image.asset(
                    'images/lokasi.png',
                    width: 23, // Add the desired width here
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik',
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(), // Spacer untuk jarak di antara teks dan gambar berikutnya
            GestureDetector(
              onTap: () {
                Get.toNamed('/editprofile', arguments: UserController().user);
              },
              child: const CircleAvatar(
                // Add the desired radius here
                backgroundColor: Colors.white,
                // Add the desired radius here
                child: Icon(
                  Icons
                      .account_circle, // Use the Icons class for built-in icons
                  size: 30, // Adjust the size of the icon as needed
                  color: Colors.black, // Set the color of the icon
                ), // Add a background color for the CircleAvatar
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_sharp),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.time_to_leave),
            label: 'Riwayat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF512E67),
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  User user = User(
      id: 1,
      name: 'Mamang',
      phone: '01923901283',
      email: 'mamang@gmail.com',
      username: 'mamang123',
      password: 'mamang123',
      businessName: 'mamangCorp',
      businessLocation: 'Jember',
      businessDescription: 'gatau ini kantor apa');
  // final User user = Get.arguments as User; //ni jug komen dulu buat desain
  String _selectedFilter =
      ''; // Variabel state untuk menyimpan nilai yang dipilih

  List<Order> orderList = [];
  String orderCount = '0';
  String orderCountMonth = '0';
  String orderSelesai = '0';

  void getOrder() async {
    var response =
        await http.get(Uri.parse('${Api.urlOrder}?user_id=${user.id}'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['order_list'];

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

  void getOrderCount() async {
    final response = await http.get(
        Uri.parse('${Api.urlOrderCount}?user_id=${UserController().user!.id}'));
    if (response.statusCode == 200) {
      int totalOrder = json.decode(response.body)['total_orders'];
      int totalOrderBulan = json.decode(response.body)['orders_this_month'];
      int totalTerverifikasi =
          json.decode(response.body)['terverifikasi_orders'];
      if (!mounted) return;
      setState(() {
        orderCount = totalOrder.toString();
        orderCountMonth = totalOrderBulan.toString();
        orderSelesai = totalTerverifikasi.toString();
      });
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  void initState() {
    super.initState();
    User? currentUser = UserController().user;
    if (currentUser == null) {
      Get.offNamed('/login');
      return;
    }
    user = currentUser;
    getOrder();
    getOrderCount();
  }

  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Halo ',
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user.name ?? '',
                              style: const TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Text(
                          'Pesan Booth Sekarang!',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 20), // Add spacing between columns
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0, top: 27.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Bisnis : ',
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(user.businessName),
                      ],
                    ),
                  ), // Add spacing between columns
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.business),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 15.0),
            sliver: SliverToBoxAdapter(
              child: Card(
                child: Container(
                  width: 340, // Add desired width
                  height: 110, // Add desired height
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    gradient: LinearGradient(
                      colors: [Color(0xFF512E67), Color(0xFF993D5C)],
                      // begin: Alignment.topLeft,
                      // end: Alignment.topRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            orderCount,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(width: 50.0),
                          Container(
                            height: 40.0,
                            width: 1.0,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 50.0),
                          Text(
                            orderSelesai,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(width: 50.0),
                          Container(
                            height: 40.0,
                            width: 1.0,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 50.0),
                          Text(
                            orderCountMonth,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Order\nKeseluruhan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                          SizedBox(width: 65.0),
                          Text(
                            "Total Order\nSelesai",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                          SizedBox(width: 65.0),
                          Text(
                            "Total Order\nBulan Ini",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    "Event yang anda ikuti",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          orderList.length > 0
              ? SliverList.builder(
                  // Provide the number of items in the list
                  itemCount: orderList.length,
                  // Build each list item dynamically
                  itemBuilder: (BuildContext context, int index) {
                    Order order = orderList[index];
                    return GestureDetector(
                        onTap: () {
                          Get.toNamed('/pembayaran', arguments: order);
                        },
                        child: CardEventOrder(order: order));
                  },
                )
              : SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 48)),
                        Text('Tidak Ada Data...'),
                        Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                        Text('Kamu belum mengikuti event.')
                      ],
                    ),
                  ),
                ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 5.0),
          ),
        ],
      ),
    );
  }

  final TextEditingController _controller = TextEditingController();
}
