import 'package:flutter/material.dart';
import 'package:myevent/pembayaran.dart';
import 'dart:ui';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  double _scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final kOutlineColor = Colors.grey; // Mendefinisikan warna outline

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 350.0,
            pinned: false,
            floating: true,
            snap: true,
            leadingWidth: 80.0,
            leading: Container(
              margin: const EdgeInsets.only(left: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(56.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    height: 56.0,
                    width: 56.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.20),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back to previous screen
                      },
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 0.0, bottom: 0.0),
                      child: Text(
                        'SUNDAY SERVICE!',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 0.0, bottom: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_pin,
                              color: Colors.red, size: 10), // Example icon
                          SizedBox(
                              width: 5), // Add spacing between icon and text
                          Text(
                            'Jember,Gelora',
                            style: TextStyle(
                              fontSize: 8.0,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 5),
                          Icon(Icons.calendar_month,
                              color: Colors.white, size: 10), // Example icon
                          SizedBox(
                              width: 5), // Add spacing between icon and text
                          Text(
                            '28 Agustus 2024',
                            style: TextStyle(
                              fontSize: 8.0,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'images/event1.png',
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 30,
                            offset: Offset(0, 200),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Container(
                  width: 40.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: kOutlineColor,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, top: 0.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Rata kiri untuk teks dalam Column
                                    children: [
                                      Text(
                                        'Harga :',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Rata kiri untuk teks dalam Row
                                          children: [
                                            Text(
                                              'Rp. 50.000',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Rp. 150.000',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Column(
                                  children: [
                                    Text(
                                      'Slot : ',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '293',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25.0, left: 25.0, top: 10.0),
                      child: Text(
                        'Festival yang menggabungkan beragam bentuk seni, meliputi seni visual, pertunjukan teater, instalasi seni, serta genre musik yang beragam, diselaraskan dengan serangkaian aktivitas hijau seperti workshop daur ulang, pameran produk ramah lingkungan, dan demonstrasi praktik-praktik berkelanjutan dalam kehidupan sehari-hari. Tujuan utamanya adalah untuk meningkatkan kesadaran akan isu-isu lingkungan, mendorong kreativitas dalam membangun solusi-solusi inovatif, serta menginspirasi tindakan nyata yang mendukung keberlanjutan lingkungan.',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  width: 10, // Height of the divider
                  color: Colors.grey, // Color of the divider
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20), // Margin around the divider
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 0.0, left: 25.0, top: 10.0),
                      child: Text(
                        'Booth : ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, top: 10.0), // Add margin here
                        width: 180.0, // Specify the width here
                        height: 100.0, // Specify the height here
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 7.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Booth A :',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Image.asset(
                                      'images/booth.png',
                                      width: 130,
                                      height: 60,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, top: 10.0), // Add margin here
                        width: 180.0, // Specify the width here
                        height: 100.0, // Specify the height here
                        child: Card(
                          child: Center(
                            child: Text(
                              'Besok Selesai',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25.0, left: 25.0, top: 10.0),
                      child: Text(
                        'Booth ini tersedia dalam berbagai ukuran dan posisi strategis di sekitar area festival. Fasilitas yang disediakan termasuk : area pameran dengan staf yang ramah perlengkapan promosi, koneksi listrik dan Wi-Fi. Tambahan peralatan seperti layar proyeksi atau sound system juga tersedia.',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  width: 10, // Height of the divider
                  color: Colors.grey, // Color of the divider
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20), // Margin around the divider
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 0.0, left: 25.0, top: 10.0),
                      child: Text(
                        'Denah Event : ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset('images/denah_booth.png')],
                ),
                SizedBox(
                  height: 90,
                ),

                // Image(image: aste)
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 300.0, // Menetapkan lebar
        height: 50.0, // Menetapkan tinggi
        child: FloatingActionButton(
          onPressed: () {
            // Fungsi yang akan dijalankan saat tombol ditekan
            print('Floating Action Button ditekan');
            _showBottomSheet(
                context); // Panggil fungsi untuk menampilkan bottom sheet
          },
          backgroundColor: Color(0xFF512E67), // Warna latar belakang
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 30.0), // Menambahkan padding horizontal
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pesan Sekarang', // Teks
                  style: TextStyle(
                    fontSize: 16.0, // Ukuran teks
                    fontWeight: FontWeight.bold, // Ketebalan teks
                    color: Colors.white, // Warna teks
                  ),
                ),
                Icon(Icons.add, color: Colors.white), // Icon
              ],
            ),
          ),
          mini: false, // Mengatur ukuran menjadi non-mini
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Menyesuaikan sudut
            // Mengatur bentuk, misalnya StadiumBorder(), bisa digunakan untuk sudut yang lebih bulat
          ),
          elevation: 6.0, // Efek bayangan
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      Color _buttonColor = Colors.transparent; // Warna default
      Color _borderColor = Colors.black; // Warna border default
      bool _isButtonClicked = false; // Status tombol "Both 1"

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 0,
                    bottom: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            if (_isButtonClicked) {
                              // Kembalikan ke warna semula
                              _buttonColor = Colors.transparent;
                              _borderColor = Colors.black;
                            } else {
                              _buttonColor = Color(
                                  0xFF512E67); // Ubah warna saat tombol ditekan
                              _borderColor = Color(
                                  0xFF512E67); // Ubah warna border saat tombol ditekan
                            }
                            _isButtonClicked =
                                !_isButtonClicked; // Ubah status tombol
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Radius sudut
                          ),
                          side: BorderSide(color: _borderColor), // Warna border
                          backgroundColor:
                              _buttonColor, // Gunakan warna yang telah diatur
                        ),
                        child: Text(
                          'Both 1',
                          style: TextStyle(
                              color: _isButtonClicked
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sisa Slot : ',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '19 Stand',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rp. 150.000',
                        style: TextStyle(
                            fontSize: 28.0, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                          left: 0,
                          right: 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nomor Stand :',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                          left: 0,
                          right: 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 180, // Menentukan lebar TextField
                              height: 50, // Menentukan tinggi TextField
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: '', // Label teks untuk input field
                                  hintText: '', // Hint teks untuk input field
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Menambahkan radius sudut
                                  ), // Tampilan border input field

                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          20), // Padding konten dalam input field
                                ),
                                onChanged: (text) {
                                  // Fungsi yang akan dijalankan saat teks berubah
                                  print('Input field berubah: $text');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Pembayaran()),
                        );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFF512E67), // Warna ungu
                                fixedSize:
                                    Size(370, 50), // Lebar dan tinggi tombol
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // Radius sudut
                                ),
                              ),
                              child: Text('Pesan Sekarang',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}



// Padding(
//               padding: EdgeInsets.only(
//                 top: 10,
//                 left: 20,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Rp . 150.000',
//                     style:
//                         TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),
//             ),