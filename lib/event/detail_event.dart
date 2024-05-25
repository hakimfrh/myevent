import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent/database/api.dart';
import 'package:myevent/event/card_booth.dart';
import 'package:myevent/model/booth.dart';
import 'package:myevent/model/eventt.dart';
import 'package:myevent/model/order.dart';
import 'package:myevent/pembayaran.dart';
import 'dart:ui';




class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  double _scrollOffset = 0.0;
  final Eventt event = Get.arguments as Eventt;
  List<Booth> boothList = [];
  String imageData = '';
  String hargaMin = '0';
  String hargaMax = '0';
  String slot = '0';
  String boothDesc =
      'Booth ini tersedia dalam berbagai ukuran dan posisi strategis di sekitar area festival. Fasilitas yang disediakan termasuk : area pameran dengan staf yang ramah perlengkapan promosi, koneksi listrik dan Wi-Fi. Tambahan peralatan seperti layar proyeksi atau sound system juga tersedia.';

  // List<Map<String, dynamic>> boothAvailable = [];
  List<int> boothRemaining = [];
  List<List<String>> boothAvailable = [];
  int selectedIndex = 0;
  String nomorBooth = '';
  @override
  void initState() {
    super.initState();
    getHarga();
    getSlot();
    getBooth();
    getBoothAvailable();
    getImage();
  }

  void getImage() async {
    try {
      final response = await http
          .get(Uri.parse('${Api.urlImage}/${event.uploadPamflet}?w=527&h=701'));
      // final response = await http.get(Uri.parse('${Api.urlImage}/${event.uploadPamflet}?w=30&h=40'));
      if (response.statusCode == 200) {
        String data = json.decode(response.body)['base64Image'];
        if (!mounted) return;
        setState(() {
          imageData = data.replaceAll(RegExp(r'\s'), '');
        });
      } else {}
    } catch (e) {}
  }

  void getSlot() async {
    final response = await http
        .get(Uri.parse('${Api.urlEventBoothTotal}?id_event=${event.idEvent}'));
    if (response.statusCode == 200) {
      String dataSlot = json.decode(response.body)['booth_total'].toString();
      if (!mounted) return;
      setState(() {
        slot = dataSlot;
      });
    } else {
      throw Exception('Failed to load image');
    }
  }

  void getHarga() async {
    final response = await http
        .get(Uri.parse('${Api.urlEventHarga}?id_event=${event.idEvent}'));
    if (response.statusCode == 200) {
      String dataMax = json.decode(response.body)['max_harga_booth'].toString();
      String dataMin = json.decode(response.body)['min_harga_booth'].toString();
      if (!mounted) return;
      setState(() {
        hargaMax = dataMax;
        hargaMin = dataMin;
      });
    } else {
      throw Exception('Failed to load image');
    }
  }

  void getBooth() async {
    var response = await http
        .get(Uri.parse('${Api.urlEventBooth}?id_event=${event.idEvent}'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['booth_list'];

      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> boothMap = data[i];
        Booth booth = Booth.fromJson(boothMap);
        if (!mounted) return;
        setState(() {
          boothList.add(booth);
        });
      }
    } else {
      // Request failed, handle error
    }
  }

  void getBoothAvailable() async {
    var response = await http.get(
        Uri.parse('${Api.urlEventBoothAvailable}?id_event=${event.idEvent}'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['booth_available'];

      for (var booth in data) {
        boothAvailable.add(List<String>.from(booth['booth_available']));
        boothRemaining.add(booth['booth_remaining']);
      }
    } else {
      // Request failed, handle error
    }
  }

  void makeOrder() async {
    // try {
    if (nomorBooth.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Pilih nomor booth"),
        duration: Durations.short4,
      ));
      return;
    }
    print('nomor booth: ${nomorBooth}');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Membuat Order"),
      duration: Durations.short4,
    ));
    var formData = <String, String>{
      'id': 1.toString(),
      'id_booth': boothList[selectedIndex].idBooth.toString(),
      'nomor_booth': nomorBooth,
      'harga_bayar': boothList[selectedIndex].hargaBooth.toString(),
    };

    var response = await http.post(Uri.parse(Api.urlOrderMake), body: formData);
    if (response.statusCode == 200) {
      Order order = Order.fromJson(jsonDecode(response.body)['order_detail']);
      Get.toNamed('/pembayaran', arguments: order);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error"),
        duration: Durations.short4,
      ));
    }
    // } catch (e) {}
  }

  String formatCurrency(int value) {
    // Gunakan pustaka intl untuk memformat angka menjadi format mata uang Rupiah
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    String result = formatCurrency.format(value);
    return result.substring(0, result.length - 3);
  }

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
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.back(); // Navigate back to previous screen
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
                      margin: const EdgeInsets.only(left: 0.0, bottom: 0.0),
                      child: Text(
                        event.namaEvent,
                        style: const TextStyle(
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
                      margin: const EdgeInsets.only(left: 0.0, bottom: 20.0),
                      child: Row(
                        children: [
                          const Icon(Icons.location_pin,
                              color: Colors.red, size: 10), // Example icon
                          const SizedBox(
                              width: 5), // Add spacing between icon and text
                          Text(
                            event.alamat,
                            style: const TextStyle(
                              fontSize: 8.0,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(width: 5),
                          const Icon(Icons.calendar_month,
                              color: Colors.white, size: 10), // Example icon
                          const SizedBox(
                              width: 5), // Add spacing between icon and text
                          Text(
                            event.pelaksanaanEvent.toString().substring(0,
                                event.pelaksanaanEvent.toString().length - 7),
                            style: const TextStyle(
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
                  imageData != ''
                      ? Image.memory(
                          base64Decode(imageData),
                          fit: BoxFit.cover,
                          // width: 80,
                        )
                      : const SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                  // Image.asset(
                  //   'images/event1.png',
                  //   fit: BoxFit.cover,
                  // ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 30,
                            offset: const Offset(0, 200),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              stretchModes: const <StretchMode>[
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
                decoration: const BoxDecoration(
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
                const SizedBox(height: 20.0),
                Row(
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
                                padding: const EdgeInsets.only(),
                                child: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Rata kiri untuk teks dalam Column
                                    children: [
                                      const Text(
                                        'Harga :',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Rata kiri untuk teks dalam Row
                                          children: [
                                            Text(
                                              formatCurrency(
                                                  int.parse(hargaMin)),
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              formatCurrency(
                                                  int.parse(hargaMax)),
                                              style: const TextStyle(
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
                              const SizedBox(
                                width: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Slot : ',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      slot,
                                      style: const TextStyle(
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
                        event.deskripsi,
                        style: const TextStyle(
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
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20), // Margin around the divider
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: 0.0, left: 25.0, top: 10.0),
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

                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // shrinkWrap: true,
                      itemCount: boothList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Booth booth = boothList[index];
                        return GestureDetector(
                          child: CardBooth(
                            booth: booth,
                          ),
                          onTap: () {
                            setState(() {
                              boothDesc = boothList[index].deskripsiBooth;
                              selectedIndex = index;
                            });
                          },
                        );
                      }),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25.0, left: 25.0, top: 10.0),
                      child: Text(
                        boothDesc,
                        style: const TextStyle(
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
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20), // Margin around the divider
                ),

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: 0.0, left: 25.0, top: 10.0),
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
                const SizedBox(
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
            _showBottomSheet(
              context,
            ); // Panggil fungsi untuk menampilkan bottom sheet
          },
          backgroundColor: const Color(0xFF512E67),
          mini: false, // Mengatur ukuran menjadi non-mini
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Menyesuaikan sudut
            // Mengatur bentuk, misalnya StadiumBorder(), bisa digunakan untuk sudut yang lebih bulat
          ),
          elevation: 6.0, // Warna latar belakang
          child: const Padding(
            padding: EdgeInsets.symmetric(
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
          ), // Efek bayangan
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showBottomSheet(BuildContext context) async {
    if (boothList.isEmpty || boothAvailable.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Loading... harap tunggu"),
        duration: Durations.short4,
      ));
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        Color _buttonColor = Colors.transparent; // Warna default
        Color _borderColor = Colors.black; // Warna border default
        // bool _isButtonClicked = false; // Status tombol "Both 1"

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 0,
                      bottom: 0,
                    ),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: boothList.length,
                        itemBuilder: (context, index) {
                          Booth booth = boothList[index];
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          return Row(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = index;
                                    // print(boothAvailable[selectedIndex]);
                                    // if (index != selectedIndex) {
                                    //   // Kembalikan ke warna semula
                                    //   _buttonColor = Colors.transparent;
                                    //   _borderColor = Colors.black;
                                    // } else {
                                    //   _buttonColor = const Color(
                                    //       0xFF512E67); // Ubah warna saat tombol ditekan
                                    //   _borderColor = const Color(
                                    //       0xFF512E67); // Ubah warna border saat tombol ditekan
                                    // }
                                    // isButtonClicked =
                                    //     !isButtonClicked; // Ubah status tombol
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Radius sudut
                                  ),
                                  side: BorderSide(
                                      color: index == selectedIndex
                                          ? const Color(0xFF512E67)
                                          : Colors.black), // Warna border
                                  backgroundColor: index == selectedIndex
                                      ? const Color(0xFF512E67)
                                      : Colors
                                          .transparent, // Gunakan warna yang telah diatur
                                ),
                                child: Text(
                                  booth.tipeBooth,
                                  style: TextStyle(
                                      color: index == selectedIndex
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          );
                        },
                        // ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Sisa Slot : ',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          boothRemaining[selectedIndex].toString(),
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatCurrency(boothList[selectedIndex].hargaBooth),
                          style: const TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Padding(
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
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 0,
                            right: 0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 370, // Menentukan lebar TextField
                                // height: 50, // Menentukan tinggi TextField
                                // child: TextField(
                                //   decoration: InputDecoration(
                                //     labelText:
                                //         '', // Label teks untuk input field
                                //     hintText: '', // Hint teks untuk input field
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(
                                //           10), // Menambahkan radius sudut
                                //     ), // Tampilan border input field

                                //     contentPadding: const EdgeInsets.symmetric(
                                //         horizontal:
                                //             20), // Padding konten dalam input field
                                //   ),
                                //   onChanged: (text) {
                                //     // Fungsi yang akan dijalankan saat teks berubah
                                //     print('Input field berubah: $text');
                                //   },
                                // ),
                                child: DropdownSearch<String>(
                                  // popupProps: const PopupProps.menu(
                                  //   showSearchBox: true,
                                  //   showSelectedItems: true,
                                  //   // disabledItemFn: (String s) =>
                                  //   //     s.startsWith('I'),
                                  // ),
                                  items: List<String>.from(
                                      boothAvailable[selectedIndex]),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Pilih Nomor Booth",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 16.0),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    return value == null?'Pilih nomor booth':null;
                                  },
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  clearButtonProps:
                                      const ClearButtonProps(isVisible: true),
                                  onChanged: (value) {
                                    nomorBooth = value ?? '';
                                    
                                  },
                                  // selectedItem: "Pilih Lokasi",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
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
                                  makeOrder();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const Pembayaran()),
                                  // );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF512E67), // Warna ungu
                                  fixedSize: const Size(
                                      370, 50), // Lebar dan tinggi tombol
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Radius sudut
                                  ),
                                ),
                                child: const Text('Pesan Sekarang',
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