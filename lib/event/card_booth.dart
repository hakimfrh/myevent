import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myevent/services/api.dart';
import 'package:myevent/model/booth.dart';
import 'package:http/http.dart' as http;

class CardBooth extends StatefulWidget {
  CardBooth({super.key, required this.booth});
  Booth booth;
  @override
  State<CardBooth> createState() => _CardBoothState(booth: booth);
}

class _CardBoothState extends State<CardBooth> {
  Booth booth;
  String imageData = '';
  @override
  void initState() {
    super.initState();
    getImage();
  }

  void getImage() async {
    try {
      final response = await http.get(
          Uri.parse('${Api.urlImage}?image_path=${booth.uploadGambarBooth}&w=236&h=314'));
      if (response.statusCode == 200) {
        String data = json.decode(response.body)['base64Image'];
        if (!mounted) return;
        setState(() {
          imageData = data.replaceAll(RegExp(r'\s'), '');
        });
      } else {}
    } catch (e) {}
  }

  _CardBoothState({required this.booth});
  @override
  Widget build(BuildContext context) {
    return Container(
  margin: const EdgeInsets.only(left: 20, top: 10.0),
  width: 180.0,
  height: 100.0,
  child: Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Radius untuk Card
    ),
    elevation: 6.0,
    child: Stack(
      children: [
        // Gambar dengan radius
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Radius untuk ClipRRect
            child: imageData != ''
                ? Image.memory(
                    base64Decode(imageData),
                    fit: BoxFit.cover, // Memenuhi Card
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
        // Teks
        Positioned(
          left: 20,
          top: 7.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(
  booth.tipeBooth,
  style: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    color: Colors.white, // Warna teks putih
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.5), // Warna shadow
        offset: Offset(1, 1), // Posisi shadow (horizontal, vertical)
        blurRadius: 2, // Blur radius
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
);
  }
}
