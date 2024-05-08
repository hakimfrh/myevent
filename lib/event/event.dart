import 'package:flutter/material.dart';
import 'dart:ui';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  double _scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final kOutlineColor = Colors.grey; // Mendefinisikan warna outline

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: false,
            floating: true,
            snap: true,
            leadingWidth: 80.0,
            leading: Container(
              margin: const EdgeInsets.only(left: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(56.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    height: 56.0,
                    width: 56.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.20),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 0.0, bottom: 16.0),
                  child: Text(
                    'SUNDAY SERVICE!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'images/event1.png',
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 30,
                            offset: Offset(0, 250),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Container(
                  width: 40.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: kOutlineColor,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, top: 0.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Rata kiri untuk teks dalam Column
                                    children: [
                                      Text(
                                        'Harga :',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Rata kiri untuk teks dalam Row
                                          children: [
                                            Text(
                                              'Rp. 50.000',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Rp. 150.000',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Column(
                                  children: [
                                    Text(
                                      'Slot : ',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      '293',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w900,
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
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25.0, left: 25.0, top: 10.0),
                      child: Text(
                        'Festival yang menggabungkan beragam bentuk seni, meliputi seni visual, pertunjukan teater, instalasi seni, serta genre musik yang beragam, diselaraskan dengan serangkaian aktivitas hijau seperti workshop daur ulang, pameran produk ramah lingkungan, dan demonstrasi praktik-praktik berkelanjutan dalam kehidupan sehari-hari. Tujuan utamanya adalah untuk meningkatkan kesadaran akan isu-isu lingkungan, mendorong kreativitas dalam membangun solusi-solusi inovatif, serta menginspirasi tindakan nyata yang mendukung keberlanjutan lingkungan.',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 0.0, left: 25.0, top: 10.0),
                      child: Text(
                        'Booth : ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                // Image(image: aste)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
