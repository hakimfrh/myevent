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
  String location = UserController().cityName??'Klik untuk cari lokasi';

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
    if(result == 'ok'){
      setState(() {
        location = UserController().cityName??'Lokasi tak diketahui';
      });
    }else{
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
                  UserController().logout();
                  Get.offNamed('/login');
                },
                child: const CircleAvatar(
                  // Third image as CircleAvatar
                  radius: 18, // Add the desired radius here
                  backgroundImage: AssetImage(
                      'images/profile.png'), // Add your image asset here
                )),
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
  }

  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(9.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Handle search logic here
                        // print(_controller.text);
                      },
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // Handle search logic here
                    // print(value);
                  },
                ),
              ),
            ),
          ),
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
                            Icon(Icons.eleven_mp_outlined),
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
                          const Text(
                            "25",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(width: 40.0),
                          Container(
                            height: 40.0,
                            width: 1.0,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 40.0),
                          const Text(
                            "11",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(width: 30.0),
                          Container(
                            height: 40.0,
                            width: 1.0,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 50.0),
                          const Text(
                            "20",
                            style: TextStyle(
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
                            "Event yang \ntelah diikuti",
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
                            "Event diikuti \nbulan ini",
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
                            "Total Event \n diikuti",
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
          SliverPadding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Text(
                    "Event yang anda ikuti",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 'Semua',
                        child: Text(
                          'Semua',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'Ditolak',
                        child: Text(
                          'Ditolak',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'Pembayaran',
                        child: Text(
                          'Pembayaran',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Add more menu items if needed
                    ],
                    onSelected: (selectedValue) {
                      // Handle filter selection here
                      print('Selected filter: $selectedValue');
                      setState(() {
                        _selectedFilter =
                            selectedValue; // Store the selected value
                      });
                    },
                  ),
                  if (_selectedFilter != null &&
                      _selectedFilter
                          .isNotEmpty) // Check if a value is selected
                    Padding(
                      padding: const EdgeInsets.only(
                          left:
                              8.0), // Add a bit of padding between text and menu
                      child: Text(
                        _selectedFilter,
                        style: const TextStyle(
                          color: Colors.black, // Set the text color to black
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverList.builder(
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
