import 'dart:convert';
import 'package:date_ranger/date_ranger.dart';
import 'package:flutter/material.dart';
import 'package:myevent/services/api.dart';
import 'package:myevent/event/card_event_list.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:myevent/model/eventt.dart';
import 'package:intl/intl.dart'; // Import package intl untuk menggunakan DateFormat
import 'package:http/http.dart' as http;
import 'package:myevent/services/user_controller.dart';

class ListEvent extends StatefulWidget {
  const ListEvent({super.key});

  @override
  State<ListEvent> createState() => _ListEventState();
}

class _ListEventState extends State<ListEvent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String search = '';
  double? latitude;
  double? longitude;
  double distance = 100;
  int hargaMax = -1;
  int hargaMin = -1;
  bool isSetDate = false;
  var initialDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  String kategori = '';
  List<Eventt> eventList = [];

  @override
  void initState() {
    super.initState();
    getEvent();
  }

  String formatCurrency(double value) {
    // Gunakan pustaka intl untuk memformat angka menjadi format mata uang Rupiah
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatCurrency.format(value);
  } // Deklarasikan variabel selectedDateTime di luar fungsi onPressedasikan variabel dateTimeList di luar fungsi onPressed

  void getEvent() async {
    String arguments = '';
    if (search.isNotEmpty) {
      if (arguments.isEmpty) {
        arguments += '?';
      } else {
        arguments += '&';
      }
      arguments += 'search=$search';
    }

    if (distance < 100 &&
        UserController().latitude != null &&
        UserController().longitude != null) {
      if (arguments.isEmpty) {
        arguments += '?';
      } else {
        arguments += '&';
      }
      arguments +=
          'latitude=${UserController().latitude}&longitude=${UserController().longitude}&distance=$distance';
    }

    if (isSetDate) {
      if (arguments.isEmpty) {
        arguments += '?';
      } else {
        arguments += '&';
      }
      arguments +=
          'start_date=${initialDateRange.start}&end_date=${initialDateRange.end}';
    }

    if (hargaMin >= 0) {
      if (arguments.isEmpty) {
        arguments += '?';
      } else {
        arguments += '&';
      }
      arguments += 'harga_min=$hargaMin';
    }
    if (hargaMax >= 0) {
      if (arguments.isEmpty) {
        arguments += '?';
      } else {
        arguments += '&';
      }
      arguments += 'harga_max=$hargaMax';
    }
    if (kategori.isNotEmpty) {
      if (arguments.isEmpty) {
        arguments += '?';
      } else {
        arguments += '&';
      }
      arguments += 'kategori=$kategori';
    }

    var response = await http.get(Uri.parse('${Api.urlEvent}$arguments'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['event_list'];
      setState(() {
        eventList = [];
      });
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> eventMap = data[i];
        Eventt event = Eventt.fromJson(eventMap);
        // if (!mounted) return;
        setState(() {
          eventList.add(event);
        });
      }
    } else {
      // Request failed, handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              getEvent();
                            });
                          },
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        search = value;
                      },
                      onSubmitted: (value) {
                        search = value;
                        setState(() {
                          getEvent();
                        });
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Event yang Tersedia",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          eventList.length > 0
              ? Expanded(
                  child: ListView.builder(
                      // scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      itemCount: eventList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Eventt event = eventList[index];
                        return CardEventList(
                          event: event,
                        );
                      }),
                )
              : Container(
                  alignment: Alignment.center,
                  child: const Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 48)),
                      Text('Event Tidak Ditemukan...'),
                      Padding(padding: EdgeInsets.symmetric(vertical: 48)),
                      // Text('Kamu belum mengikuti event.')
                    ],
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
        child: const Icon(Icons.filter_alt_rounded, color: Colors.white),
        backgroundColor: const Color(0xFF512E67),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      endDrawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Remove curved edge
        ),
        child: ListView(
          padding: const EdgeInsets.only(),
          children: <Widget>[
            ListTile(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the drawer
                },
              ),
              title: const Text(
                "Sortir Event",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lokasi",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rubik',
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.location_pin, color: Colors.red, size: 15),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Jarak Lokasi Maksimal : ',
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        distance >= 100 ? '-' : '${distance.round()} km',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        width: 300.0,
                        child: Slider(
                          value: distance,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: distance >= 100
                              ? '-'
                              : distance.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              distance = value.roundToDouble();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: 300, // Height of the divider
                    color: Colors.black, // Color of the divider
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10), // Margin around the divider
                  ),
                  const Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal & Waktu",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rubik',
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.calendar_month_outlined,
                            color: Colors.black, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: DateRanger(
                          initialRange: initialDateRange,
                          onRangeChanged: (range) {
                            setState(() {
                              initialDateRange = range;
                              isSetDate = true;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 1,
                    width: 300, // Height of the divider
                    color: Colors.black, // Color of the divider
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10), // Margin around the divider
                  ),
                  const Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Harga",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rubik',
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.price_check, color: Colors.black, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Harga Minimal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: const Icon(Icons.money),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0), // Added padding
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Harga Minimal';
                      } else if (!value.contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                        return 'Harga Minimal harus di isi';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      hargaMin = int.parse(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Harga Maksimal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: const Icon(Icons.description),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0), // Added padding
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Harga Maksimal';
                      } else if (!value.contains(RegExp(r'^[a-zA-Z0-9_]+$'))) {
                        return 'Harga Maksimal harus di isi';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      hargaMax = int.parse(value);
                    },
                  ),
                  Container(
                    height: 1,
                    width: 300, // Height of the divider
                    color: Colors.black, // Color of the divider
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10), // Margin around the divider
                  ),
                  const Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Kategori",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rubik',
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.price_check, color: Colors.black, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Kategori Event",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSearchBox: false,
                            showSelectedItems: true,
                          ),

                          items: ["Pameran", "Seminar", "Konser", 'Lainnya'],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Pilih Kategori",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          clearButtonProps:
                              const ClearButtonProps(isVisible: true),
                          onChanged: (value) {
                            kategori = value ?? '';
                          },
                          // selectedItem: "Pilih Lokasi",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Spasi antara tombol
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            distance = 100;
                            isSetDate = false;
                            initialDateRange = DateTimeRange(
                                start: DateTime.now(), end: DateTime.now());
                            hargaMin = -1;
                            hargaMax = -1;
                            kategori = '';
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(
                              color: Colors.black), // Outline hitam
                          minimumSize:
                              const Size(130, 40), // Lebar dan tinggi tombol

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Radius sudut
                          ),
                        ),
                        child: const Text('Reset'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            getEvent();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF512E67), // Warna ungu
                          fixedSize:
                              const Size(130, 40), // Lebar dan tinggi tombol
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Radius sudut
                          ),
                        ),
                        child: const Text('Terapkan',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
