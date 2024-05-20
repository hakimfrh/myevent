// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'eventt.dart';

part 'booth.g.dart';

@JsonSerializable()
class Booth {
  @JsonKey(name: 'id_booth')
  final int idBooth;
  @JsonKey(name: 'upload_gambar_booth')
  final String uploadGambarBooth;
  @JsonKey(name: 'tipe_booth')
  final String tipeBooth;
  @JsonKey(name: 'harga_booth')
  final int hargaBooth;
  @JsonKey(name: 'jumlah_booth')
  final int jumlahBooth;
  @JsonKey(name: 'deskripsi_booth')
  final String deskripsiBooth;
  // @JsonKey(name: 'id_event')
  // final int id_event;
  final Eventt? event;
  Booth({
    required this.idBooth,
    required this.uploadGambarBooth,
    required this.tipeBooth,
    required this.hargaBooth,
    required this.jumlahBooth,
    required this.deskripsiBooth,
    this.event,
  });

factory Booth.fromJson(Map<String, dynamic> json) => _$BoothFromJson(json);

  Map<String, dynamic> toJson() => _$BoothToJson(this);
}
