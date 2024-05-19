import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:myevent/event/card_event.dart';
import 'package:myevent/model/event.dart';

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
      status: 'Selesai',
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
  int activeIndex = 0;

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
    if (activeIndex < getStepperData().length - 1) {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Konfirmasi Pemesanan'),
        ),
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
              child: ListView.builder(
                itemCount:
                    1, // Hanya satu item untuk menampilkan konten langkah saat ini
                itemBuilder: (context, index) {
                  // Periksa langkah saat ini
                  switch (activeIndex) {
                    case 0:
                      // Langkah 1: Tampilkan konten untuk langkah pertama
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Step One Content",
                              style: TextStyle(fontSize: 20),
                            ),
                            // Membungkus ListView dengan Expanded untuk menentukan ketinggian
                            Expanded(
                              child: ListView.builder(
                                itemCount: eventList
                                    .length, // Jumlah total item dalam daftar
                                itemBuilder: (context, index) {
                                  Eventt event = eventList[index];
                                  return CardEvent(event: event);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    case 1:
                      // Langkah 2: Tampilkan konten untuk langkah kedua
                      return Center(
                        child: Text(
                          "Step Two Content",
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    case 2:
                      // Langkah 3: Tampilkan konten untuk langkah ketiga
                      return Center(
                        child: Text(
                          "Step Three Content",
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    case 3:
                      // Langkah 4: Tampilkan konten untuk langkah keempat
                      return Center(
                        child: Text(
                          "Step Four Content",
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    default:
                      // Default jika activeIndex tidak sesuai
                      return Container();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _goToPreviousStep,
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: _goToNextStep,
                    child: const Text('Next'),
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
