// ignore_for_file: unnecessary_const

import 'dart:async';
import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent/services/api.dart';
import 'package:myevent/event/card_event_order.dart';
import 'package:myevent/model/eventt.dart';
import 'package:myevent/model/order.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Pembayaran());
}

class Pembayaran extends StatefulWidget {
  const Pembayaran({Key? key}) : super(key: key);

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

bool isValid = true;
Order order = Get.arguments as Order;
List<Order> eventList = [
  order,
];
File? _image;
String imageData = '';
String _buttonText = 'Selanjutnya';
String orderStatus = '';

class _PembayaranState extends State<Pembayaran> {
  int activeIndex = 1;
  int getOrderStatusPage() {
    if (order.statusOrder == 'validasi') return 1;
    if (order.statusOrder == 'ditolak') return 1;
    if (order.statusOrder == 'diterima') return 2;
    if (order.statusOrder == 'menunggu pembayaran') return 3;
    // if (order.statusOrder == 'validasi pembayaran') return 3;
    if (order.statusOrder == 'terverivikasi') return 3;
    return 3;
  }

  @override
  void initState() {
    eventList = [];
    order = Get.arguments as Order;
    eventList.add(order);

    _image = null;
    activeIndex = getOrderStatusPage();
    if (activeIndex == 1) _buttonText = 'Kembali';
    if (activeIndex == 2) _buttonText = 'Kirim Pembayaran';
    if (activeIndex == 3) _buttonText = 'Kembali';
    // if (activeIndex == 3) getImage();

    String status = order.statusOrder.toLowerCase();
    if(status == 'validasi') orderStatus = 'Validasi';
    if(status == 'ditolak') orderStatus = 'Ditolak';
    if(status == 'diterima') orderStatus = 'Menunggu Pembayaran';
    if(status == 'menunggu pembayaran') orderStatus = 'Verifikasi Pembayaran';
    if(status == 'terverivikasi') orderStatus = 'Selesai';
    super.initState();
  }

  void getImage() async {
    try {
      final response = await http.get(Uri.parse(
          '${Api.urlImage}?image_path=${order.imgBuktiTransfer}&w=136&h=181'));
      if (response.statusCode == 200) {
        String data = json.decode(response.body)['base64Image'];
        if (!mounted) return;
        setState(() {
          imageData = data.replaceAll(RegExp(r'\s'), '');
        });
      } else {}
    } catch (e) {}
  }

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
            color: activeIndex >= 0 ? const Color(0xFF993D5C) : Colors.red,
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
            color: activeIndex >= 1 ? const Color(0xFF993D5C) : Colors.grey,
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
            color: activeIndex >= 2 ? const Color(0xFF993D5C) : Colors.grey,
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
            color: activeIndex >= 3 ? const Color(0xFF993D5C) : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: const Icon(Icons.check,
              size: 20, color: Colors.white), // Adjust size
        ),
      ),
    ];
  }

  void _goToNextStep() {
    if (activeIndex == 1) {
      Get.back();
      return;
    }
    if (activeIndex == 2) {
      uploadBayar();
      return;
    }
    if (activeIndex == 3) {
      Get.back();
      return;
    }

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
    const StepOneContent(),
    const StepTwoContent(),
    const StepThreeContent(),
    const StepFourContent(),
  ];

  void uploadBayar() async {
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Waktu Pembayaran Telah Habis"),
        duration: Durations.short4,
      ));
    return;
    }
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Upload bukti pembayaran"),
        duration: Durations.short4,
      ));
      print('gambarnya gaada');
      return;
    }
    String base64Image = base64Encode(_image!.readAsBytesSync());
    String imageType = path.extension(_image!.path);

    var formData = <String, String>{
      'id_order': order.idOrder.toString(),
      'image_data': base64Image,
      'image_type': imageType,
    };
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Mengunggah bukti bayar"),
      duration: Durations.short4,
    ));
    var response =
        await http.post(Uri.parse(Api.urlOrderBayar), body: formData);
    if (response.statusCode == 200) {
      setState(() {
        _buttonText = 'kembali';
        activeIndex = 3;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(jsonDecode(response.body)['message']),
        duration: Durations.short4,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Action to perform when back arrow is pressed
              Navigator.pop(context);
            },
          ),
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
                activeBarColor: const Color(0xFF993D5C),
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
                              const Color(0xFF512E67), // Atur warna teks button
                        ),
                        child: Text(_buttonText),
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
  const StepOneContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Menunggu Verifikasi Penyelenggara",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                Order event = eventList[index];
                return CardEventOrder(order: event);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StepTwoContent extends StatelessWidget {
  const StepTwoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Menunggu \nVerifikasi Penyelenggara",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                Order event = eventList[index];
                return CardEventOrder(order: event);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StepThreeContent extends StatefulWidget {
  const StepThreeContent({super.key});

  @override
  _StepThreeContentState createState() => _StepThreeContentState();
}

class _StepThreeContentState extends State<StepThreeContent> {
  final ImagePicker _picker = ImagePicker();
  late Timer _timer;
  late DateTime _endTime;
  late Duration _remainingTime;
  final DateTime _startTime = order.tglDiterima ?? DateTime.now();

  @override
  void initState() {
    super.initState();
    _endTime = _startTime.add(const Duration(hours: 24));
    _remainingTime = _endTime.difference(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = _endTime.difference(DateTime.now());
        if (_remainingTime.isNegative) {
          _timer.cancel();
          _remainingTime = Duration.zero;
          isValid = false;
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

  Future<void> _requestPermission(Permission permission) async {
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  Future<void> _showPicker(BuildContext context) async {
    await _requestPermission(Permission.camera);
    await _requestPermission(Permission.storage);
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari galery'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Ambil foto'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _imgFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _imgFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sisa Waktu Bayar ",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 5),
                Text(
                  formatDuration(_remainingTime),
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: eventList.length,
                  itemBuilder: (context, index) {
                    Order event = eventList[index];
                    return CardEventOrder(order: event);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
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
            padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 0.7, // Height of the divider
                      color: Colors.grey, // Color of the divider
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 0,
                      ), // Margin around the divider
                    ),
                    const Flexible(
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
                            Text(
                              "Waktu Pemesanan",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "Batas waktu pembayaran",
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
                        padding: const EdgeInsets.only(top: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              order.booth!.event!.noRekening,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              order.booth!.event!.namaRekening,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('EEEE dd-MM-yyyy', 'id_ID')
                                  .format(order.tglOrder),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('EEEE dd-MM-yyyy', 'id_ID').format(
                                  order.tglDiterima!.add(Duration(days: 1))),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 0.7, // Height of the divider
                      color: Colors.grey, // Color of the divider
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 0,
                      ), // Margin around the divider
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Bukti Pembayaran :',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        child: _image != null
                            ? Image.file(
                                _image!,
                                isAntiAlias: true,
                                // width: 100,
                                // height: 100,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                    const Text(
                                      'Klik untuk memilih gambar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                      ),
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
  const StepFourContent({super.key});
  String formatCurrency(int value) {
    // Gunakan pustaka intl untuk memformat angka menjadi format mata uang Rupiah
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    String result = formatCurrency.format(value);
    return result.substring(0, result.length - 3);
  } // Deklarasikan variabel selectedDateTime di luar fungsi onPressedasikan variabel dateTimeList di luar fungsi onPressed

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Container(
          height: 520,
          margin: const EdgeInsets.only(top: 0, left: 24, right: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 0, right: 15),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/fpsucc.png',
                        width: 100,
                        height: 100,
                      ),
                      const Text(
                        "Pembayaran Terkirim",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 20, left: 10),
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
                                    height: 14,
                                  ),
                                  Text(
                                    "Waktu :",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    "Tanggal :",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    "Nomor Rekening Tujuan :",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    "Rekening Atas Nama :",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    "ID Transaksi :",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    "Jenis Booth :",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 14,
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
                              padding:
                                  const EdgeInsets.only(top: 20, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    orderStatus,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    DateFormat.Hm()
                                        .format(order.tglBayar ?? DateTime(0)),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    DateFormat('EEEE dd-MM-yyyy', 'id_ID')
                                        .format(order.tglBayar ?? DateTime(0)),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    order.booth!.event!.noRekening,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    order.booth!.event!.namaRekening,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    order.idOrder.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    '${order.booth!.tipeBooth} - ${order.nomorBooth}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    formatCurrency(order.booth!.hargaBooth),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(order.statusOrder=='terverifikasi'?'Pemesanan telah selesai, Cek Email kamu':''),
                          ],
                        ),
                      )
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Padding(
                      //       padding: EdgeInsets.only(left: 16),
                      //       child: Text(
                      //         'Bukti Pembayaran :',
                      //         textAlign: TextAlign.left,
                      //         style: TextStyle(
                      //             fontSize: 12, fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //     imageData != ''
                      //         ? Image.memory(
                      //             base64Decode(imageData),
                      //             // width: 80,
                      //             fit: BoxFit.cover,
                      //           )
                      //         : const CircularProgressIndicator(),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
