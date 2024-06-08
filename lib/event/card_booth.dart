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
      margin: const EdgeInsets.only(left: 20, top: 10.0), // Add margin here
      width: 180.0, // Specify the width here
      height: 100.0, // Specify the height here
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 7.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booth.tipeBooth,
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
                  ),
                  imageData != ''
                      ? Image.memory(
                          base64Decode(imageData),
                          // fit: BoxFit.cover,
                          height: 50,
                          // width: 130,
                        )
                      : const SizedBox(
                          height: 25.0,
                          width: 25.0,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                  // Image.asset(
                  //   'images/booth.png',
                  //   width: 130,
                  //   height: 60,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
