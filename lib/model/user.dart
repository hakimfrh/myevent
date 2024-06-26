// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    int id;
    @JsonKey(name: 'nama_lengkap')
    String? name;
    @JsonKey(name: 'no_telp')
    String phone;
    String email;
    String? username;
    String? password;
    @JsonKey(name: 'nama_perusahaan')
    String businessName;
    @JsonKey(name: 'alamat_perusahaan')
    String businessLocation;
    @JsonKey(name: 'deskripsi_perusahaan')
    String? businessDescription;
  User({
    this.id = 0,
    this.name,
    required this.phone,
    required this.email,
    this.username,
    this.password,
    required this.businessName,
    required this.businessLocation,
    this.businessDescription,
  });
    // @JsonKey(name: 'email_verified_at')
    // DateTime? emailVerifiedAt;
    // @JsonKey(name: 'created_at')
    // DateTime? createdAt;
    // @JsonKey(name: 'updated_at')
    // DateTime? updatedAt;

  

factory User.fromMap(Map<String, dynamic> json) => _$UserFromJson(json);

Map<String, dynamic> toMap() => _$UserToJson(this);

}
