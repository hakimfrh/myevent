import 'package:flutter/material.dart';
import 'package:myevent/event/detail_event.dart';

class CardEventList extends StatefulWidget {
  const CardEventList({super.key});

  @override
  State<CardEventList> createState() => _CardEventListState();
}

class _CardEventListState extends State<CardEventList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Event()),
        );
      },
    );
  }
}