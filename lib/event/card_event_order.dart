import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myevent/services/api.dart';
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
  int retry = 0;
  String orderStatus = '';
  CardEventOrderState({required this.order});

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    String eventColor;
    String status = order.statusOrder.toLowerCase();
    if (status == 'selesai' ||
        status == 'terverifikasi' ||
        status == 'validasi pembayaran') {
      eventColor = '1';
    } else if (status == 'ditolak') {
      eventColor = '3';
    } else {
      eventColor = '2';
    }

    if(status == 'validasi') orderStatus = 'Validasi';
    if(status == 'ditolak') orderStatus = 'Ditolak';
    if(status == 'diterima') orderStatus = 'Menunggu Pembayaran';
    if(status == 'menunggu pembayaran') orderStatus = 'Verifikasi Pembayaran';
    if(status == 'terverivikasi') orderStatus = 'Selesai';

    String trimString(String s) {
      int length = 90;
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

    String formatCurrency(int value) {
      // Gunakan pustaka intl untuk memformat angka menjadi format mata uang Rupiah
      final formatCurrency =
          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
      String result = formatCurrency.format(value);
      return result.substring(0, result.length - 3);
    }

    return GestureDetector(
      onDoubleTap: () {
        Get.toNamed('/event', arguments: order.booth!.event);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Text(
                  DateFormat('EEEE dd-MM-yyyy', 'id_ID')
                      .format(order.booth!.event!.pelaksanaanEvent),
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
              child: IntrinsicHeight(
                child: Container(
                  width: double
                      .infinity, // Pastikan lebar Card mengikuti container
                  constraints: BoxConstraints(
                    minWidth: 200.0, // Lebar minimum Card
                    maxWidth: 400.0, // Lebar maksimum Card
                  ),
                  child: Column(
                    children: [
                      Container(
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
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                orderStatus.toLowerCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            imageData != ''
                                ? Image.memory(
                                    base64Decode(imageData),
                                    width: 70,
                                  )
                                : const CircularProgressIndicator(),
                            const SizedBox(width: 10.0),
                            Container(
                              height: 80,
                              width: 1,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 10.0),
                            Flexible(
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
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        '${order.booth!.tipeBooth} - ${order.nomorBooth}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.end,
                                        softWrap: true,
                                      ),
                                      Spacer(),
                                      Container(
                                        height: 15,
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      Spacer(),
                                      Text(
                                        formatCurrency(order.hargaBayar),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trimString(
                                              order.booth!.deskripsiBooth),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              order.booth!.event!.alamat,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Rubik',
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.date_range,
                                                  size: 15,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  DateFormat('dd/MM/yyyy HH:mm')
                                                      .format(order
                                                          .booth!
                                                          .event!
                                                          .pelaksanaanEvent),
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Rubik',
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
}
