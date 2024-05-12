import 'package:flutter/material.dart';
import 'package:myevent/event/detail_event.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart'; // Import package intl untuk menggunakan DateFormat

class ListEvent extends StatefulWidget {
  const ListEvent({super.key});

  @override
  State<ListEvent> createState() => _ListEventState();
}

class _ListEventState extends State<ListEvent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _dropdownFormKey = GlobalKey<FormState>();
  late String _selectedValue;
  double _currentValue = 500; // initial value for the slider

  DateTime? selectedDateTime;

  String formatCurrency(double value) {
    // Gunakan pustaka intl untuk memformat angka menjadi format mata uang Rupiah
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatCurrency.format(value);
  } // Deklarasikan variabel selectedDateTime di luar fungsi onPressedasikan variabel dateTimeList di luar fungsi onPressed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 9, left: 9, top: 10),
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
                      onPressed: () {},
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            Padding(
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "28 Agustus 2013",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 9, left: 9),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Event()),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFFFFFFFF),
                        child: Container(
                          width: 350,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'images/event1.png',
                                        width: 80,
                                      ),
                                      const SizedBox(width: 10.0),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        width: 20,
                                        indent: 30,
                                        endIndent: 30,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 15, 20, 0),
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
                                              const SizedBox(height: 5),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rp. 150.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    softWrap: true,
                                                  ),
                                                  Text(
                                                    "Rp. 300.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    width: 8,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Jember, IDN",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Rubik',
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Image.asset(
                                                    'images/wa.png',
                                                    width: 10,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "081726371286",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "28 Agustus 2013",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 9, left: 9),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Event()),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFFFFFFFF),
                        child: Container(
                          width: 350,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'images/event1.png',
                                        width: 80,
                                      ),
                                      const SizedBox(width: 10.0),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        width: 20,
                                        indent: 30,
                                        endIndent: 30,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 15, 20, 0),
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
                                              const SizedBox(height: 5),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rp. 150.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    softWrap: true,
                                                  ),
                                                  Text(
                                                    "Rp. 300.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    width: 8,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Jember, IDN",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Rubik',
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Image.asset(
                                                    'images/wa.png',
                                                    width: 10,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "081726371286",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "28 Agustus 2013",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 9, left: 9),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Event()),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFFFFFFFF),
                        child: Container(
                          width: 350,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'images/event1.png',
                                        width: 80,
                                      ),
                                      const SizedBox(width: 10.0),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        width: 20,
                                        indent: 30,
                                        endIndent: 30,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 15, 20, 0),
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
                                              const SizedBox(height: 5),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rp. 150.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    softWrap: true,
                                                  ),
                                                  Text(
                                                    "Rp. 300.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    width: 8,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Jember, IDN",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Rubik',
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Image.asset(
                                                    'images/wa.png',
                                                    width: 10,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "081726371286",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "28 Agustus 2013",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 9, left: 9),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Event()),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFFFFFFFF),
                        child: Container(
                          width: 350,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'images/event1.png',
                                        width: 80,
                                      ),
                                      const SizedBox(width: 10.0),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        width: 20,
                                        indent: 30,
                                        endIndent: 30,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 15, 20, 0),
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
                                              const SizedBox(height: 5),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rp. 150.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    softWrap: true,
                                                  ),
                                                  Text(
                                                    "Rp. 300.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    width: 8,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Jember, IDN",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Rubik',
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Image.asset(
                                                    'images/wa.png',
                                                    width: 10,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "081726371286",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 10, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "28 Agustus 2013",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 9, left: 9),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Event()),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFFFFFFFF),
                        child: Container(
                          width: 350,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'images/event1.png',
                                        width: 80,
                                      ),
                                      const SizedBox(width: 10.0),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        width: 20,
                                        indent: 30,
                                        endIndent: 30,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 15, 20, 0),
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
                                              const SizedBox(height: 5),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rp. 150.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    softWrap: true,
                                                  ),
                                                  Text(
                                                    "Rp. 300.000",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    width: 8,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Jember, IDN",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Rubik',
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Image.asset(
                                                    'images/wa.png',
                                                    width: 10,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "081726371286",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
        child: Icon(Icons.filter_alt_rounded, color: Colors.white),
        backgroundColor: Color(0xFF512E67),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      endDrawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Remove curved edge
        ),
        child: ListView(
          padding: EdgeInsets.only(),
          children: <Widget>[
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the drawer
                },
              ),
              title: Text(
                "Sortir Event",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Provinsi",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 0),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          clearButtonProps: ClearButtonProps(isVisible: true),
                          onChanged: print,
                          // selectedItem: "Pilih Lokasi",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Kabupaten",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 0),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          clearButtonProps: ClearButtonProps(isVisible: true),
                          onChanged: print,
                          // selectedItem: "Pilih Lokasi",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Kecamatan",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 0),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          clearButtonProps: ClearButtonProps(isVisible: true),
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
                    margin: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10), // Margin around the divider
                  ),
                  Padding(
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
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(500, 40),
                        backgroundColor: Color(0xFF512E67),
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
                          style: TextStyle(
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
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10), // Margin around the divider
                        ),
                        Icon(Icons.access_time_rounded,
                            color: Colors.white, size: 14),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${selectedDateTime != null ? DateFormat('HH:mm:ss').format(selectedDateTime!) : 'Pilih Waktu'}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Rubik',
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.calendar_month_outlined,
                            color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 300, // Height of the divider
                    color: Colors.black, // Color of the divider
                    margin: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10), // Margin around the divider
                  ),
                  Padding(
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
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Price: ${formatCurrency(_currentValue)}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 20.0),
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
                    margin: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10), // Margin around the divider
                  ),
                  Padding(
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Kecamatan",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 0),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                          clearButtonProps: ClearButtonProps(isVisible: true),
                          onChanged: print,
                          // selectedItem: "Pilih Lokasi",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
                          side:
                              BorderSide(color: Colors.black), // Outline hitam
                          minimumSize: Size(130, 40), // Lebar dan tinggi tombol

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Radius sudut
                          ),
                        ),
                        child: Text('Reset'),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Aksi untuk tombol "Terapkan"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF512E67), // Warna ungu
                          fixedSize: Size(130, 40), // Lebar dan tinggi tombol
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Radius sudut
                          ),
                        ),
                        child: Text('Terapkan',
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
