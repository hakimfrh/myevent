import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myevent/database/api.dart';
import '../model/order.dart';

class CardEventOrder extends StatefulWidget {
  const CardEventOrder({super.key, required this.order});
  final Order order;
  @override
  State<CardEventOrder> createState() => CardEventOrderState(order: order);
}

class CardEventOrderState extends State<CardEventOrder> {
  Order order;
  String imageData = '';
  String hargaMin = '';
  String hargaMax = '';
  int retry = 0;
  CardEventOrderState({required this.order});

  @override
  void initState() {
    super.initState();
    getHarga();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    String eventColor;
    String status = order.booth!.event!.status.toLowerCase();
    if (status == 'selesai') {
      eventColor = '1';
    } else if (status.contains('menunggu')) {
      eventColor = '2';
    } else if (status == 'ditolak') {
      eventColor = '3';
    } else {
      eventColor = '3';
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed('/event',arguments: order.booth!.event);
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Text(
                  order.booth!.event!.pelaksanaanEvent.toString(),
                  style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: Container(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 23,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              eventColor == '1'
                                  ? const Color(0xFFF35AE24)
                                  : eventColor == '2'
                                      ? const Color(0xFFFFFC107)
                                      : const Color(0xFFFF3D3D),
                              eventColor == '1'
                                  ? const Color(0xFF16480F)
                                  : eventColor == '2'
                                      ? const Color(0xFF997404)
                                      : const Color(0xFF992424)
                            ],
                            // colors: [Color(0xFFF35AE24), Color(0xFF16480F)],
                            // colors: [Color(0xFFFFFC107), Color(0xFF997404)],
                            // colors: [Color(0xFFFF3D3D), Color(0xFF992424)],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Id Event : ${order.booth!.event!.idEvent}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                order.booth!.event!.status,
                                style: const TextStyle(
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
                            // Image.asset(
                            //   'images/event1.png',
                            //   width: 80,
                            // ),
                            imageData != ''
                                ? Image.memory(
                                    base64Decode(imageData),
                                    // fit: BoxFit.cover,
                                    width: 80,
                                  )
                                : CircularProgressIndicator(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.booth!.event!.namaEvent,
                                      // ignore: prefer_const_constructors
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
                                    Text(
                                      order.booth!.event!.deskripsi.substring(0,150),
                                      style: const TextStyle(
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Teks harga pertama
                                        Text(
                                          'Rp. $hargaMin',
                                          // '123',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                        ),
                                        // Teks harga kedua
                                        Text(
                                          'Rp. $hargaMax',
                                          // '123',
                                          style: const TextStyle(
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
                                        Text(
                                          order.booth!.event!.alamat,
                                          style: const TextStyle(
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
                                        Text(
                                          order.booth!.event!.whatsapp ?? '',
                                          style: const TextStyle(
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
          )
        ],
      ),
    );
  }

  void getImage() async {
    try {
      final response = await http
          .get(Uri.parse('${Api.urlImage}/${order.booth!.event!.uploadPamflet}?w=136&h=181'));
      if (response.statusCode == 200) {
        String data = json.decode(response.body)['base64Image'];
        if (!mounted) return;
        setState(() {
          imageData = data.replaceAll(RegExp(r'\s'), '');
        });
      } else {}
    } catch (e) {
      if(retry <= 3){
        retry++;
        getImage();
      }
    }
  }

  void getHarga() async {
    final response = await http
        .get(Uri.parse('${Api.urlEventHarga}?id_event=${order.booth!.event!.idEvent}'));
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
}
