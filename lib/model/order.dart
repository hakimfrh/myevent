// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'booth.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'id_order')
  final int idOrder;
  @JsonKey(name: 'status_order')
  final String statusOrder;
  @JsonKey(name: 'nomor_booth')
  final String nomorBooth;
  @JsonKey(name: 'harga_bayar')
  final int hargaBayar;
  @JsonKey(name: 'img_bukti_transfer')
  final String imgBuktiTransfer;
  @JsonKey(name: 'tgl_order')
  final String tglOrder;
  @JsonKey(name: 'tgl_verifikasi')
  final String tglVerifikasi;
  final int id;
  @JsonKey(name: 'id_booth')
  final int idBooth;
  final Booth? booth;
  Order({
    required this.idOrder,
    required this.statusOrder,
    required this.nomorBooth,
    required this.hargaBayar,
    required this.imgBuktiTransfer,
    required this.tglOrder,
    required this.tglVerifikasi,
    required this.id,
    required this.idBooth,
    this.booth,
  });
  
 

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
