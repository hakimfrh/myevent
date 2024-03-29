// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
    String nama;
    String alamat;
    String username;
    String password;
    String email;
    String namaPerusahaan;
    String deskipsiPerusahaan;
    String nomor;
    String lokasi;
    String? id;

  User({
    required this.nama,
    required this.alamat,
    required this.username,
    required this.password,
    required this.email,
    required this.namaPerusahaan,
    required this.deskipsiPerusahaan,
    required this.nomor,
    required this.lokasi,
    this.id
  });


    Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "alamat": alamat,
        "username": username,
        "password": password,
        "email":email,
        "namaPerusahaan":namaPerusahaan,
        "deskripsiPerusahaan":deskipsiPerusahaan,
        "nomor":nomor,
        "lokasi":lokasi,
    };
}
