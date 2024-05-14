import 'package:flutter/material.dart';

import '../model/event.dart';

class CardEvent extends StatelessWidget {
  final Eventt event;
  const CardEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String eventColor;
    String status = event.status.toLowerCase();
    if (status == 'selesai') {
      eventColor = '1';
    } else if (status.contains('menunggu')) {
      eventColor = '2';
    } else if (status == 'ditolak') {
      eventColor = '3';
    } else {
      eventColor = '3';
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              Text(
                event.tanggal,
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
                              "Id Event : ${event.idEvent}",
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
                              event.status,
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
                          Image.asset(
                            'images/event1.png',
                            width: 80,
                          ),
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
                                    event.namaEvent,
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
                                    event.deskripsiEvent,
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
                                        event.hargaMin,
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
                                        event.hargaMax,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'images/lokasi.png',
                                        width: 8, // Add the desired width here
                                      ),
                                      const SizedBox(
                                          width:
                                              5), // Tambahkan jarak antara gambar dan teks
                                      Text(
                                        event.lokasi,
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
                                        width: 10, // Add the desired width here
                                      ),
                                      const SizedBox(
                                          width:
                                              5), // Tambahkan jarak antara gambar dan teks
                                      Text(
                                        event.noWa,
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
    );
  }
}
