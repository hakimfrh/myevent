import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    int id;
    String name;
    String phone;
    String email;
    String username;
    String password;
    @JsonKey(name: 'business_name')
    String businessName;
    @JsonKey(name: 'business_location')
    String businessLocation;
    @JsonKey(name: 'business_description')
    String businessDescription;
    @JsonKey(name: 'email_verified_at')
    DateTime? emailVerifiedAt;
    @JsonKey(name: 'created_at')
    DateTime? createdAt;
    @JsonKey(name: 'updated_at')
    DateTime? updatedAt;

    User({
        this.id = 0,
        required this.name,
        required this.phone,
        required this.email,
        required this.username,
        this.password = "",
        required this.businessName,
        required this.businessLocation,
        required this.businessDescription,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });

factory User.fromMap(Map<String, dynamic> json) => _$UserFromJson(json);

Map<String, dynamic> toMap() => _$UserToJson(this);

}
