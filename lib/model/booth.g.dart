// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booth _$BoothFromJson(Map<String, dynamic> json) => Booth(
      idBooth: (json['id_booth'] as num).toInt(),
      uploadGambarBooth: json['upload_gambar_booth'] as String,
      tipeBooth: json['tipe_booth'] as String,
      hargaBooth: (json['harga_booth'] as num).toInt(),
      jumlahBooth: (json['jumlah_booth'] as num).toInt(),
      deskripsiBooth: json['deskripsi_booth'] as String,
      event: json['event'] == null
          ? null
          : Eventt.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoothToJson(Booth instance) => <String, dynamic>{
      'id_booth': instance.idBooth,
      'upload_gambar_booth': instance.uploadGambarBooth,
      'tipe_booth': instance.tipeBooth,
      'harga_booth': instance.hargaBooth,
      'jumlah_booth': instance.jumlahBooth,
      'deskripsi_booth': instance.deskripsiBooth,
      'event': instance.event,
    };
