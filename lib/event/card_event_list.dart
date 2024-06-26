import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent/services/api.dart';
import 'package:myevent/event/detail_event.dart';
import 'package:myevent/model/eventt.dart';
import 'package:http/http.dart' as http;
import 'package:myevent/services/user_controller.dart';

class CardEventList extends StatefulWidget {
  const CardEventList({super.key, required this.event});
  final Eventt event;
  @override
  State<CardEventList> createState() => _CardEventListState(event: event);
}

class _CardEventListState extends State<CardEventList> {
  Eventt event;
  String imageData = '';
  String hargaMin = '0';
  String hargaMax = '0';
  String jarak = '';

  _CardEventListState({required this.event});

  @override
  void initState() {
    super.initState();
    getHarga();
    getImage();
    if(UserController().latitude != null && UserController().longitude != null){
      double distance = calculateDistance(UserController().latitude!, UserController().longitude!, double.parse(event.latitude), double.parse(event.longitude));
      jarak = ' - ${distance.toStringAsFixed(2)} km';
    }
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

  void getImage() async {
    try {
      final response = await http.get(Uri.parse(
          '${Api.urlImage}?image_path=${event.uploadPamflet}&w=136&h=181'));
      if (response.statusCode == 200) {
        String data = json.decode(response.body)['base64Image'];
        if (!mounted) return;
        setState(() {
          imageData = data.replaceAll(RegExp(r'\s'), '');
        });
      } else {}
    } catch (e) {}
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

  String formatCurrency(double value) {
    // Gunakan pustaka intl untuk memformat angka menjadi format mata uang Rupiah
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    String result = formatCurrency.format(value);
    return result.substring(0, result.length - 3);
  } // Deklarasikan variabel selectedDateTime di luar fungsi onPressedasikan variabel dateTimeList di luar fungsi onPressed

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Earth's radius in kilometers

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = R * c;
    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 10, top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                DateFormat('EEEE dd-MM-yyyy', 'id_ID')
                    .format(event.pelaksanaanEvent),
                style: const TextStyle(
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
          padding: const EdgeInsets.only(right: 9, left: 9),
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/event', arguments: event);
            },
            child: Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: const Color(0xFFFFFFFF),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            imageData != ''
                                ? Image.memory(
                                    base64Decode(imageData),
                                    width: 80,
                                  )
                                : const CircularProgressIndicator(),
                            const SizedBox(width: 10.0),
                            Container(
                              width: 1,
                              height:
                                  100, // Set the height of the vertical line
                              color: Colors
                                  .grey, // Set the color of the vertical line
                            ),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5.0, 18, 25, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize
                                      .min, // Adjust the height based on content
                                  children: [
                                    Text(
                                      event.namaEvent,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      maxLines: 1, // Set maximum lines to 1
                                      overflow: TextOverflow
                                          .ellipsis, // Add ellipsis for overflow
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      trimString(event.deskripsi),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                      ),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      // maxLines: 2, // Set maximum lines to 2
                                      // overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Harga mulai dari:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            formatCurrency(
                                                double.parse(hargaMin)),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ),
                                        Text(
                                          '-',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                        ),
                                        Flexible(
                                          child: Text(
                                            formatCurrency(
                                                double.parse(hargaMax)),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
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
                                        Expanded(
                                          child: Text(
                                            event.alamat+jarak,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Rubik',
                                            ),
                                            overflow: TextOverflow
                                                .ellipsis, // Add ellipsis for overflow
                                          ),
                                        ),
                                        // SizedBox(width: 15),
                                        // Image.asset(
                                        //   'images/wa.png',
                                        //   width: 10,
                                        // ),
                                        // const SizedBox(width: 5),
                                        // Expanded(
                                        //   child: Text(
                                        //     event.whatsapp ?? '',
                                        //     style: const TextStyle(
                                        //       fontSize: 10,
                                        //       fontWeight: FontWeight.bold,
                                        //       fontFamily: 'Rubik',
                                        //     ),
                                        //     overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                                        //     textAlign: TextAlign.end, // Align text to the right
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
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
        )
      ],
    );
  }
}
