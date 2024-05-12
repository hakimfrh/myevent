import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent/getx_state.dart';
import 'package:myevent/model/user.dart';
import 'package:myevent/navigation_drawer.dart';
import 'package:myevent/user_list.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
  const Dashboard({super.key});
}

class DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

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
            Image.asset(
              'images/lokasi.png',
              width: 23, // Add the desired width here
            ),
            const Text(
              "Jember, IDN",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
              ),
            ),
            const Spacer(), // Spacer untuk jarak di antara teks dan gambar berikutnya
            const CircleAvatar(
              // Third image as CircleAvatar
              radius: 18, // Add the desired radius here
              backgroundImage:
                  AssetImage('images/profile.png'), // Add your image asset here
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
  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)!.settings.arguments as User;
    // final User user = Get.arguments as User; //ni jug komen dulu buat desain
    String _selectedFilter =
        ''; // Variabel state untuk menyimpan nilai yang dipilih
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
                              // user.name
                              'Kepeng',
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
                  const Padding(
                    padding: EdgeInsets.only(right: 0.0, top: 27.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
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
                        // Text(user.businessName),
                        Text('Cakei')
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
          const SliverPadding(
            padding: EdgeInsets.only(left: 30.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    "28 Agustus 2013",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverToBoxAdapter(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: SizedBox(
                  width: 350,
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 23,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFF35AE24), Color(0xFF16480F)],
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Id Event : 92389",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Text(
                                  "Selesai",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15.0, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/event1.png',
                                width: 80,
                              ),
                              const SizedBox(width: 10.0),
                              const VerticalDivider(
                                color: Colors.grey, // Warna garis
                                thickness: 1, // Ketebalan garis
                                width: 20, // Lebar garis
                                indent: 30, // Jarak dari atas
                                endIndent: 30, // Jarak dari bawah
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5.0, 15, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "SUNDAY SERVICE",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 19,
                                        ),
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                      ),
                                      const SizedBox(height: 5),
                                      // Text festival
                                      const Text(
                                        "Festival yang menggabungkan seni, musik, dan aktivitas hijau untuk mempromosikan kesadaran lingkungan dan kreativitas.",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Harga Mulai Dari :",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ),
                                      const SizedBox(
                                          height:
                                              5), // Tambahkan jarak sebelum teks harga
                                      // Row untuk menampilkan harga
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Teks harga pertama
                                          Text(
                                            "Rp. 150.000",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                          // Teks harga kedua
                                          Text(
                                            "Rp. 300.000",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'images/lokasi.png',
                                            width:
                                                8, // Add the desired width here
                                          ),
                                          const SizedBox(
                                              width:
                                                  5), // Tambahkan jarak antara gambar dan teks
                                          const Text(
                                            "Jember, IDN",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Rubik',
                                            ),
                                          ),
                                          const Spacer(), // Spacer untuk mendorong teks harga ke sisi kanan
                                          // Teks harga
                                          Image.asset(
                                            'images/wa.png',
                                            width:
                                                10, // Add the desired width here
                                          ),
                                          const SizedBox(
                                              width:
                                                  5), // Tambahkan jarak antara gambar dan teks
                                          const Text(
                                            "081726371286",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Rubik',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10.0),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(left: 30.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    "28 Agustus 2013",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverToBoxAdapter(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: SizedBox(
                  width: 350,
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 23,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFFC107), Color(0xFF997404)],
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Id Event : 2090",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Text(
                                  "Menunggu Pembayaran",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15.0, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/event1.png',
                                width: 80,
                              ),
                              const SizedBox(width: 10.0),
                              const VerticalDivider(
                                color: Colors.grey, // Warna garis
                                thickness: 1, // Ketebalan garis
                                width: 20, // Lebar garis
                                indent: 30, // Jarak dari atas
                                endIndent: 30, // Jarak dari bawah
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5.0, 15, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "SUNDAY SERVICE",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 19,
                                        ),
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                      ),
                                      const SizedBox(height: 5),
                                      // Text festival
                                      const Text(
                                        "Festival yang menggabungkan seni, musik, dan aktivitas hijau untuk mempromosikan kesadaran lingkungan dan kreativitas.",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Harga Mulai Dari :",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ),
                                      const SizedBox(
                                          height:
                                              5), // Tambahkan jarak sebelum teks harga
                                      // Row untuk menampilkan harga
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Teks harga pertama
                                          Text(
                                            "Rp. 150.000",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                          // Teks harga kedua
                                          Text(
                                            "Rp. 300.000",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'images/lokasi.png',
                                            width:
                                                8, // Add the desired width here
                                          ),
                                          const SizedBox(
                                              width:
                                                  5), // Tambahkan jarak antara gambar dan teks
                                          const Text(
                                            "Jember, IDN",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Rubik',
                                            ),
                                          ),
                                          const Spacer(), // Spacer untuk mendorong teks harga ke sisi kanan
                                          // Teks harga
                                          Image.asset(
                                            'images/wa.png',
                                            width:
                                                10, // Add the desired width here
                                          ),
                                          const SizedBox(
                                              width:
                                                  5), // Tambahkan jarak antara gambar dan teks
                                          const Text(
                                            "081726371286",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Rubik',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 5.0),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(left: 30.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    "28 September 2013",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverToBoxAdapter(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: SizedBox(
                  width: 350,
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 23,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFF3D3D), Color(0xFF992424)],
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Id Event : 92389",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Text(
                                  "Selesai",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15.0, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/event1.png',
                                width: 80,
                              ),
                              const SizedBox(width: 10.0),
                              const VerticalDivider(
                                color: Colors.grey, // Warna garis
                                thickness: 1, // Ketebalan garis
                                width: 20, // Lebar garis
                                indent: 30, // Jarak dari atas
                                endIndent: 30, // Jarak dari bawah
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5.0, 15, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "SUNDAY SERVICE",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 19,
                                        ),
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                      ),
                                      const SizedBox(height: 5),
                                      // Text festival
                                      const Text(
                                        "Festival yang menggabungkan seni, musik, dan aktivitas hijau untuk mempromosikan kesadaran lingkungan dan kreativitas.",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Harga Mulai Dari :",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ),
                                      const SizedBox(
                                          height:
                                              5), // Tambahkan jarak sebelum teks harga
                                      // Row untuk menampilkan harga
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Teks harga pertama
                                          Text(
                                            "Rp. 150.000",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                          // Teks harga kedua
                                          Text(
                                            "Rp. 300.000",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'images/lokasi.png',
                                            width:
                                                8, // Add the desired width here
                                          ),
                                          const SizedBox(
                                              width:
                                                  5), // Tambahkan jarak antara gambar dan teks
                                          const Text(
                                            "Jember, IDN",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Rubik',
                                            ),
                                          ),
                                          const Spacer(), // Spacer untuk mendorong teks harga ke sisi kanan
                                          // Teks harga
                                          Image.asset(
                                            'images/wa.png',
                                            width:
                                                10, // Add the desired width here
                                          ),
                                          const SizedBox(
                                              width:
                                                  5), // Tambahkan jarak antara gambar dan teks
                                          const Text(
                                            "081726371286",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Rubik',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
