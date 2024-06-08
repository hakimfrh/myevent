import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myevent/services/api.dart';
import 'package:myevent/event/card_event_list.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:myevent/model/eventt.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart'; // Import package intl untuk menggunakan DateFormat
import 'package:http/http.dart' as http;

class ListEvent extends StatefulWidget {
  const ListEvent({super.key});

  @override
  State<ListEvent> createState() => _ListEventState();
}

class _ListEventState extends State<ListEvent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _dropdownFormKey = GlobalKey<FormState>();
  late String _selectedValue;

  String search = '';
  double _currentValue = 500; // initial value for the slider
  DateTime? selectedDateTime;
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
    var response = await http.get(Uri.parse('${Api.urlEvent}$arguments'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['event_list'];
      eventList = [];
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> eventMap = data[i];
        Eventt event = Eventt.fromJson(eventMap);
        if (!mounted) return;
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
          Expanded(
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
                    "Provinsi",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items: [
                            "Brazil",
                            "Italia (Disabled)",
                            "Tunisia",
                            'Canada'
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Pilih Provinsi",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          clearButtonProps:
                              const ClearButtonProps(isVisible: true),
                          onChanged: print,
                          // selectedItem: "Pilih Lokasi",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Kabupaten",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items: [
                            "Brazil",
                            "Italia (Disabled)",
                            "Tunisia",
                            'Canada'
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Pilih Kabupaten",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          clearButtonProps:
                              const ClearButtonProps(isVisible: true),
                          onChanged: print,
                          // selectedItem: "Pilih Lokasi",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Kecamatan",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            disabledItemFn: (String s) => s.startsWith('I'),
                          ),

                          items: [
                            "Brazil",
                            "Italia (Disabled)",
                            "Tunisia",
                            'Canada'
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Pilih Kecamatan",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          clearButtonProps:
                              const ClearButtonProps(isVisible: true),
                          onChanged: print,
                          // selectedItem: "Pilih Lokasi",
                        ),
                      ],
                    ),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(500, 40),
                        backgroundColor: const Color(0xFF512E67),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      selectedDateTime = await showOmniDateTimePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        lastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        is24HourMode: false,
                        isShowSeconds: false,
                        minutesInterval: 1,
                        secondsInterval: 1,
                        isForce2Digits: true,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0)),
                        constraints: const BoxConstraints(
                          maxWidth: 350,
                          maxHeight: 650,
                        ),
                        transitionBuilder: (context, anim1, anim2, child) {
                          return FadeTransition(
                            opacity: anim1.drive(
                              Tween(
                                begin: 0,
                                end: 1,
                              ),
                            ),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                        barrierDismissible: true,
                        selectableDayPredicate: (dateTime) {
                          // Disable 25th Feb 2023
                          if (dateTime == DateTime(2023, 2, 25)) {
                            return false;
                          } else {
                            return true;
                          }
                        },
                      );

                      print("dateTime: $selectedDateTime");

                      setState(
                          () {}); // Panggil setState untuk memperbarui tampilan
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedDateTime != null ? DateFormat('yyyy-MM-dd').format(selectedDateTime!) : 'Pilih Tanggal'}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Rubik',
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 10,
                          width: 1, // Height of the divider
                          color: Colors.white, // Color of the divider
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10), // Margin around the divider
                        ),
                        // Icon(Icons.access_time_rounded,
                        //     color: Colors.white, size: 14),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        Text(
                          "${selectedDateTime != null ? DateFormat('HH:mm:ss').format(selectedDateTime!) : 'Pilih Waktu'}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Rubik',
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.calendar_month_outlined,
                            color: Colors.white, size: 18),
                      ],
                    ),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Price: ${formatCurrency(_currentValue)}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        width: 300.0,
                        child: Slider(
                          value: _currentValue,
                          min: 0,
                          max: 1000,
                          divisions: 100,
                          label: formatCurrency(_currentValue),
                          onChanged: (double value) {
                            setState(() {
                              _currentValue = value;
                            });
                          },
                        ),
                      ),
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
                    "Kecamatan",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            disabledItemFn: (String s) => s.startsWith('I'),
                          ),

                          items: [
                            "Brazil",
                            "Italia (Disabled)",
                            "Tunisia",
                            'Canada'
                          ],
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
                          onChanged: print,
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
                          // Aksi untuk tombol "Reset"
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
                          // Aksi untuk tombol "Terapkan"
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