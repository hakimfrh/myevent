// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:json_annotation/json_annotation.dart';

// part 'eventt.g.dart';

// @JsonSerializable()
// class Eventt {
//   @JsonKey(name: 'id_event')
//   int idEvent;
//   @JsonKey(name: 'nama_event')
//   String namaEvent;
//   @JsonKey(name: 'penyelenggara_event')
//   String penyelenggaraEvent;
//   // @JsonKey(name: 'upload_ktp')
//   // String uploadKtp;
//   @JsonKey(name: 'kategori_event')
//   String kategoriEvent;
//   @JsonKey(name: 'tanggal_event')
//   String tanggalEvent;
//   @JsonKey(name: 'jam_event')
//   String jamEvent;
//   @JsonKey(name: 'tanggal_pendaftaran')
//   DateTime tanggalPendaftaran;
//   @JsonKey(name: 'tanggal_penutupan')
//   DateTime tanggalPenutupan;
//   String deskripsi;
//   String alamat;
//   String longitude;
//   String latitude;
//   @JsonKey(name: 'upload_denah')
//   String uploadDenah;
//   @JsonKey(name: 'upload_pamflet')
//   String uploadPamflet;
//   @JsonKey(name: 'no_rekening')
//   String noRekening;
//   @JsonKey(name: 'nama_rekening')
//   String namaRekening;
//   @JsonKey(name: 'nama_bank')
//   String namaBank;
//   String email;
//   String? instagram;
//   String? whatsapp;
//   String status;
//   @JsonKey(name: 'user_id')
//   int userId;
//   Eventt({
//     required this.idEvent,
//     required this.namaEvent,
//     required this.penyelenggaraEvent,
//     required this.kategoriEvent,
//     required this.tanggalEvent,
//     required this.jamEvent,
//     required this.tanggalPendaftaran,
//     required this.tanggalPenutupan,
//     required this.deskripsi,
//     required this.alamat,
//     required this.longitude,
//     required this.latitude,
//     required this.uploadDenah,
//     required this.uploadPamflet,
//     required this.noRekening,
//     required this.namaRekening,
//     required this.namaBank,
//     required this.email,
//     this.instagram,
//     this.whatsapp,
//     required this.status,
//     required this.userId,
//   });

//   factory Eventt.fromJson(Map<String, dynamic> json) => _$EventtFromJson(json);

//   Map<String, dynamic> toJson() => _$EventtToJson(this);

// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Eventt {
  String idEvent;
  String status;
  String tanggal;
  String namaEvent;
  String deskripsiEvent;
  String hargaMin;
  String hargaMax;
  String lokasi;
  String noWa;
  String cover;
  
  Eventt({
    required this.idEvent,
    required this.status,
    required this.tanggal,
    required this.namaEvent,
    required this.deskripsiEvent,
    required this.hargaMin,
    required this.hargaMax,
    required this.lokasi,
    required this.noWa,
    required this.cover,
  });
}

