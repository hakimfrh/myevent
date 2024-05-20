// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Eventt _$EventtFromJson(Map<String, dynamic> json) => Eventt(
      idEvent: (json['id_event'] as num).toInt(),
      namaEvent: json['nama_event'] as String,
      penyelenggaraEvent: json['penyelenggara_event'] as String,
      kategoriEvent: json['kategori_event'] as String,
      tanggalEvent: json['tanggal_event'] as String,
      jamEvent: json['jam_event'] as String,
      tanggalPendaftaran: DateTime.parse(json['tanggal_pendaftaran'] as String),
      tanggalPenutupan: DateTime.parse(json['tanggal_penutupan'] as String),
      deskripsi: json['deskripsi'] as String,
      alamat: json['alamat'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      uploadDenah: json['upload_denah'] as String,
      uploadPamflet: json['upload_pamflet'] as String,
      noRekening: json['no_rekening'] as String,
      namaRekening: json['nama_rekening'] as String,
      namaBank: json['nama_bank'] as String,
      email: json['email'] as String,
      instagram: json['instagram'] as String?,
      whatsapp: json['whatsapp'] as String?,
      status: json['status'] as String,
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$EventtToJson(Eventt instance) => <String, dynamic>{
      'id_event': instance.idEvent,
      'nama_event': instance.namaEvent,
      'penyelenggara_event': instance.penyelenggaraEvent,
      'kategori_event': instance.kategoriEvent,
      'tanggal_event': instance.tanggalEvent,
      'jam_event': instance.jamEvent,
      'tanggal_pendaftaran': instance.tanggalPendaftaran.toIso8601String(),
      'tanggal_penutupan': instance.tanggalPenutupan.toIso8601String(),
      'deskripsi': instance.deskripsi,
      'alamat': instance.alamat,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'upload_denah': instance.uploadDenah,
      'upload_pamflet': instance.uploadPamflet,
      'no_rekening': instance.noRekening,
      'nama_rekening': instance.namaRekening,
      'nama_bank': instance.namaBank,
      'email': instance.email,
      'instagram': instance.instagram,
      'whatsapp': instance.whatsapp,
      'status': instance.status,
      'user_id': instance.userId,
    };
