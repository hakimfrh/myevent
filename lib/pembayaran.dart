import 'dart:async';
import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myevent/event/card_event.dart';
import 'package:myevent/model/eventt.dart';

void main() {
  runApp(const Pembayaran());
}

class Pembayaran extends StatefulWidget {
  const Pembayaran({Key? key}) : super(key: key);

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

List<Eventt> eventList = [
  Eventt(
      idEvent: '123123',
      status: 'Menunggu Verifikasi',
      tanggal: '28 Februari 2023',
      namaEvent: 'Sunday Services',
      deskripsiEvent:
          'Festival yang menggabungkan seni, musik, dan aktivitas hijau untuk mempromosikan kesadaran lingkungan dan kreativitas.',
      hargaMin: '250.000',
      hargaMax: '500.000',
      lokasi: 'jember',
      noWa: '12308128123',
      cover: 'logo.png'),
];

class _PembayaranState extends State<Pembayaran> {
  int activeIndex = 1;

  List<StepperData> getStepperData() {
    return [
      StepperData(
        title: StepperText(
          "",
          textStyle: TextStyle(
            fontSize: 10,
            color: activeIndex >= 0 ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: StepperText(
          "Pendaftaran",
          textStyle: TextStyle(
            color: activeIndex >= 0 ? Colors.black : Colors.grey,
          ),
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(6), // Adjust padding for smaller icon
          decoration: BoxDecoration(
            color: activeIndex >= 0 ? Color(0xFF993D5C) : Colors.red,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: const Icon(Icons.looks_one,
              size: 20, color: Colors.white), // Adjust size
        ),
      ),
      StepperData(
        title: StepperText(
          "",
          textStyle: TextStyle(
            fontSize: 10,
            color: activeIndex >= 1 ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: StepperText(
          "Verifikasi",
          textStyle: TextStyle(
            color: activeIndex >= 1 ? Colors.black : Colors.grey,
          ),
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(6), // Adjust padding for smaller icon
          decoration: BoxDecoration(
            color: activeIndex >= 1 ? Color(0xFF993D5C) : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: const Icon(Icons.looks_two,
              size: 20, color: Colors.white), // Adjust size
        ),
      ),
      StepperData(
        title: StepperText(
          "",
          textStyle: TextStyle(
            fontSize: 10,
            color: activeIndex >= 2 ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: StepperText(
          "Pembayaran",
          textStyle: TextStyle(
            color: activeIndex >= 2 ? Colors.black : Colors.grey,
          ),
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(6), // Adjust padding for smaller icon
          decoration: BoxDecoration(
            color: activeIndex >= 2 ? Color(0xFF993D5C) : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: const Icon(Icons.looks_3,
              size: 20, color: Colors.white), // Adjust size
        ),
      ),
      StepperData(
        title: StepperText(
          "",
          textStyle: TextStyle(
            fontSize: 10,
            color: activeIndex >= 3 ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: StepperText(
          "Selesai",
          textStyle: TextStyle(
            color: activeIndex >= 3 ? Colors.black : Colors.grey,
          ),
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(6), // Adjust padding for smaller icon
          decoration: BoxDecoration(
            color: activeIndex >= 3 ? Color(0xFF993D5C) : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: const Icon(Icons.check,
              size: 20, color: Colors.white), // Adjust size
        ),
      ),
    ];
  }

  void _goToNextStep() {
    if (activeIndex < stepWidgets.length - 1) {
      setState(() {
        activeIndex += 1;
      });
    }
  }

  void _goToPreviousStep() {
    if (activeIndex > 0) {
      setState(() {
        activeIndex -= 1;
      });
    }
  }

  final List<Widget> stepWidgets = [
    StepOneContent(),
    StepTwoContent(),
    StepThreeContent(),
    StepFourContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      // Action to perform when back arrow is pressed
      Navigator.pop(context);
    },
  ),
  title: const Text('Konfirmasi Pemesanan'),
)
,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 5),
              child: AnotherStepper(
                stepperList: getStepperData(),
                stepperDirection: Axis.horizontal,
                iconWidth: 32, // Decrease width
                iconHeight: 32, // Decrease height
                activeBarColor: Color(0xFF993D5C),
                inActiveBarColor: Colors.grey,
                inverted: true,
                verticalGap: 20, // Decrease vertical gap
                activeIndex: activeIndex,
                barThickness: 4, // Decrease bar thickness
              ),
            ),
            Expanded(
              child: stepWidgets[activeIndex],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                        8.0), // Beri padding di sekitar button
                    child: SizedBox(
                      width: 330,
                      height: 50, // Atur tinggi button
                      child: ElevatedButton(
                        onPressed: _goToNextStep,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Radius button
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Color(0xFF512E67), // Atur warna teks button
                        ),
                        child: const Text('Selanjutnya'),
                      ),
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

class StepOneContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Menunggu Verifikasi Penyelenggara",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                Eventt event = eventList[index];
                return CardEvent(event: event);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StepTwoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Menunggu \nVerifikasi Penyelenggara",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                Eventt event = eventList[index];
                return CardEvent(event: event);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StepThreeContent extends StatefulWidget {
  @override
  _StepThreeContentState createState() => _StepThreeContentState();
}

class _StepThreeContentState extends State<StepThreeContent> {
  late Timer _timer;
  late DateTime _endTime;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.now().add(Duration(minutes: 30));
    _remainingTime = _endTime.difference(DateTime.now());

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = _endTime.difference(DateTime.now());
        if (_remainingTime.isNegative) {
          _timer.cancel();
          _remainingTime = Duration.zero;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sisa Waktu Bayar ",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 5),
                Text(
                  formatDuration(_remainingTime),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: eventList.length,
                  itemBuilder: (context, index) {
                    Eventt event = eventList[index];
                    return CardEvent(event: event);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Detail Pembayaran",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: 0.7, // Height of the divider
                      color: Colors.grey, // Color of the divider
                      margin: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 0,
                      ), // Margin around the divider
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nomor Rekening Tujuan :",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "Rekening Atas Nama :",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "08816283756",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sevri Vendrain",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 0.7, // Height of the divider
                      color: Colors.grey, // Color of the divider
                      margin: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 0,
                      ), // Margin around the divider
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StepFourContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Column(
                children: [
                  Image.asset(
                    'images/fpsucc.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    "Pembayaran Terkirim",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: 0.7, // Height of the divider
                        color: Colors.grey, // Color of the divider
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 0,
                        ), // Margin around the divider
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status :",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Waktu :",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Tanggal :",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Nomor Rekening Tujuan :",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Rekening Atas Nama :",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "ID Transaksi :",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Jenis Booth :",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Harga :",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Selesai",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "17:00",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "17 - 03 - 2024",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "010927322824",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Sevri Vendrain",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "ID012963625317",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Booth A17",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Rp. 150.000",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 0.7, // Height of the divider
                        color: Colors.grey, // Color of the divider
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 0,
                        ), // Margin around the divider
                      ),
                    ],
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
