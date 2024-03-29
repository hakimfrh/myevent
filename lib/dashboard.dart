import 'package:flutter/material.dart';
import 'package:myevent/model/user.dart';
import 'package:myevent/navigation_drawer.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
  const Dashboard({super.key});
}

class DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    NavDrawer(),
    Text('Profile Page'),
    Text('Profile Page'),
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
            const Text("Jember, IDN", style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
             ),),
            const Spacer(), // Spacer untuk jarak di antara teks dan gambar berikutnya
             const CircleAvatar( // Third image as CircleAvatar
              radius: 18, // Add the desired radius here
              backgroundImage: AssetImage('images/profile.png'), // Add your image asset here
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
            icon: Icon(Icons.home),
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
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
 Widget build(BuildContext context) {
  final user = ModalRoute.of(context)!.settings.arguments as User;
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(9.0),
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
        Expanded(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Halo ',style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
                Text(user.nama, style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
            const Text('Pesan Booth Sekarang!',style: TextStyle(
              fontSize: 15,
            ),),
          ],
        ),
      ),
      const Spacer(),
      const SizedBox(width: 20), // Add spacing between columns
      Padding(
        padding: const EdgeInsets.only(right: 10.0,top: 27.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const Row(
              children: [
                Text('Bisnis : ',style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                
                ),),
              ],
            ),
            Text(user.namaPerusahaan),
           
          ],
        ),
      ), // Add spacing between columns
      const Padding(
        padding: EdgeInsets.only(right: 33.0,top: 35.0),
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
Padding(
  padding: const EdgeInsets.all(0.0),
  child: Card(
    child: Container(
      width: 375, // Add desired width
      height: 110, // Add desired height
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        gradient: LinearGradient(
         colors: [Color(0xFF512E67), Color(0xFF993D5C)],
          // begin: Alignment.topLeft,
          // end: Alignment.topRight,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 8.0,top: 80.0)),
               Text("25",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 30,
          ),),
         Spacer(),
         Spacer(),
               Text("11",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 30,
          ),),
   Spacer(),       
   Spacer(),       
               Text("203",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 30,
          ),),
         Spacer(),
            ],
          ),
          Padding( padding: EdgeInsets.only(left: 0.0,top: 00.0)),
          Row(
            children: [
              Text("data")
            ],
          )
        ],
      ),
    ),
  ),
),
   const Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          Text("COMING SOOOOOOOOOOOOOOOOOON")
        ],
      ),),
      const Spacer(),
      const Spacer(),
      ],
    
    ),

  );
}

  final TextEditingController _controller = TextEditingController();

}

