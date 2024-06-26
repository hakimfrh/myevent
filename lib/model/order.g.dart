// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      idOrder: (json['id_order'] as num).toInt(),
      statusOrder: json['status_order'] as String,
      nomorBooth: json['nomor_booth'] as String,
      hargaBayar: (json['harga_bayar'] as num).toInt(),
      imgBuktiTransfer: json['img_bukti_transfer'] as String?,
      tglOrder: DateTime.parse(json['tgl_order'] as String),
      tglVerifikasi: json['tgl_verifikasi'] == null
          ? null
          : DateTime.parse(json['tgl_verifikasi'] as String),
      tglBayar: json['tgl_bayar'] == null
          ? null
          : DateTime.parse(json['tgl_bayar'] as String),
      tglDiterima: json['tgl_diterima'] == null
          ? null
          : DateTime.parse(json['tgl_diterima'] as String),
      tglDitolak: json['tgl_ditolak'] == null
          ? null
          : DateTime.parse(json['tgl_ditolak'] as String),
      id: (json['id'] as num).toInt(),
      idBooth: (json['id_booth'] as num).toInt(),
      booth: json['booth'] == null
          ? null
          : Booth.fromJson(json['booth'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id_order': instance.idOrder,
      'status_order': instance.statusOrder,
      'nomor_booth': instance.nomorBooth,
      'harga_bayar': instance.hargaBayar,
      'img_bukti_transfer': instance.imgBuktiTransfer,
      'tgl_order': instance.tglOrder.toIso8601String(),
      'tgl_verifikasi': instance.tglVerifikasi?.toIso8601String(),
      'tgl_bayar': instance.tglBayar?.toIso8601String(),
      'tgl_diterima': instance.tglDiterima?.toIso8601String(),
      'tgl_ditolak': instance.tglDitolak?.toIso8601String(),
      'id': instance.id,
      'id_booth': instance.idBooth,
      'booth': instance.booth,
    };
