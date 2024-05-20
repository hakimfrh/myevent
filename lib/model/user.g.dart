// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['nama_lengkap'] as String,
      phone: json['no_telp'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String? ?? "",
      businessName: json['nama_perusahaan'] as String,
      businessLocation: json['alamat_perusahaan'] as String,
      businessDescription: json['deskripsi_perusahaan'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nama_lengkap': instance.name,
      'no_telp': instance.phone,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'nama_perusahaan': instance.businessName,
      'alamat_perusahaan': instance.businessLocation,
      'deskripsi_perusahaan': instance.businessDescription,
    };
