import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
    String status = order.statusOrder.toLowerCase();
    if (status == 'selesai' ||
        status == 'diterima' ||
        status == 'terverivikasi' ||
        status == 'validasi pembayaran') {
      eventColor = '1';
    } else if (status == 'ditolak') {
      eventColor = '3';
    } else {
      eventColor = '2';
    }

    String trimString(String s) {
      int length = 150;
      if (s.length <= length) return s;
      
      List<String> sList = s.split(' ');
      String result = '';
      int index = 0;
      while (result.length < length) {
        result += sList[index];
        result += ' ';
        index++;
      }
      result += '. Baca Selengkapnya...';
      return result;
    }

    return GestureDetector(
      onDoubleTap: () {
        Get.toNamed('/event', arguments: order.booth!.event);
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
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  color: Colors.white,
  child: Container(
    height: 180,
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
                    order.statusOrder.toLowerCase(),
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
                imageData != ''
                    ? Image.memory(
                        base64Decode(imageData),
                        width: 70,
                      )
                    : CircularProgressIndicator(),
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
                    padding: const EdgeInsets.fromLTRB(5.0, 20, 25, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.booth!.event!.namaEvent,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                        SizedBox(height: 5,),
                          
                           FutureBuilder<void>(
    future: Future.delayed(const Duration(milliseconds: 1170)), // Menunda perubahan selama 500 milidetik
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text(
          'Loading...', // Teks sementara saat menunggu
          style: TextStyle(
            color: Colors.grey,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        );
      } else {
        return Text(
          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
              .format(double.parse(hargaMin)),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
          textAlign: TextAlign.start,
          softWrap: true,
        );
      }
    },
  ),

  //yang dibawah itu yang belum dikasih format ke rupiah, jika nanti terjadi error, 
  //pake yang di bawah saja, karena untuk mengganti currency nya itu datanya harus terpanggil dulu baru bisa di ubah ,
  // masalahnya loading setiap hape itu beda beda, nah jika belum terpanggil dulu datanya, dan akan di ubahcurecynya maka akan eror sebentar,
  // nanti jika datanya telah dipanggil baru tidak akan terjadi error. bebas dah mau pake yang mana

                          // Text(
                          //     NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
                          //             .format(double.parse(hargaMin)),
                          //         style: const TextStyle(
                          //           color: Colors.black,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 24,
                          //         ),
                          //         textAlign: TextAlign.start,
                          //         softWrap: true,
                          //       ),
                                                      SizedBox(height: 5,),

                              Text(
                                'Booth Gold - A',
                                // 'Rp. $hargaMin',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                                softWrap: true,
                              ),
                              SizedBox(height: 5,),
                        // const SizedBox(height: 5),
                        // Text(
                        //   trimString(order.booth!.event!.deskripsi),
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.normal,
                        //     fontSize: 10,
                        //   ),
                        //   textAlign: TextAlign.start,
                        //   softWrap: true,
                        // ),
                        // const SizedBox(height: 5),
                        // const Text(
                        //   "Harga Mulai Dari :",
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 10,
                        //   ),
                        //   textAlign: TextAlign.start,
                        //   softWrap: true,
                        // ),
                        // const SizedBox(height: 5),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'Rp. $hargaMin',
                        //         style: const TextStyle(
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 17,
                        //         ),
                        //         textAlign: TextAlign.start,
                        //         softWrap: true,
                        //       ),
                        //     ),
                            
                        //     // Expanded(
                        //     //   child: Text(
                        //     //     'Rp. $hargaMax',
                        //     //     style: const TextStyle(
                        //     //       color: Colors.black,
                        //     //       fontWeight: FontWeight.bold,
                        //     //       fontSize: 15,
                        //     //     ),
                        //     //     textAlign: TextAlign.end,
                        //     //     softWrap: true,
                        //     //   ),
                        //     // ),
                        //   ],
                        // ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'images/lokasi.png',
                              width: 8,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                order.booth!.event!.alamat,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik',
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                            ),
                        Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                    order.booth!.event!.pelaksanaanEvent.toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Rubik',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
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
      final response = await http.get(Uri.parse(
          '${Api.urlImage}?image_path=${order.booth!.event!.uploadPamflet}&w=136&h=181'));
      if (response.statusCode == 200) {
        String data = json.decode(response.body)['base64Image'];
        if (!mounted) return;
        setState(() {
          imageData = data.replaceAll(RegExp(r'\s'), '');
        });
      } else {}
    } catch (e) {
      if (retry <= 3) {
        retry++;
        getImage();
      }
    }
  }

  void getHarga() async {
    final response = await http.get(Uri.parse(
        '${Api.urlEventHarga}?id_event=${order.booth!.event!.idEvent}'));
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
