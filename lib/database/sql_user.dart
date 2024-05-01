/*
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:myevent/model/user.dart';

class UserDatabase {
  late Database _database;

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, nama TEXT, alamat TEXT, username TEXT, password TEXT, email TEXT, namaPerusahaan TEXT, deskripsiPerusahaan TEXT, nomor TEXT, lokasi TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(User user) async {
    await _database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getUsers() async {
    final List<Map<String, dynamic>> userMaps = await _database.query('users');
    return List.generate(userMaps.length, (i) {
      return User(
        id: userMaps[i]['id'],
        nama: userMaps[i]['nama'],
        alamat: userMaps[i]['alamat'],
        username: userMaps[i]['username'],
        password: userMaps[i]['password'],
        email: userMaps[i]['email'],
        namaPerusahaan: userMaps[i]['namaPerusahaan'],
        deskipsiPerusahaan: userMaps[i]['deskripsiPerusahaan'],
        nomor: userMaps[i]['nomor'],
        lokasi: userMaps[i]['lokasi'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    await _database.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    await _database.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<User> login(String email, String password) async {
    final List<Map<String, dynamic>> userMaps = await _database.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);

    if (userMaps.isNotEmpty) {
      return User(
        nama: userMaps[0]['nama'],
        alamat: userMaps[0]['alamat'],
        username: userMaps[0]['username'],
        password: userMaps[0]['password'],
        email: userMaps[0]['email'],
        namaPerusahaan: userMaps[0]['namaPerusahaan'],
        deskipsiPerusahaan: userMaps[0]['deskripsiPerusahaan'],
        nomor: userMaps[0]['nomor'],
        lokasi: userMaps[0]['lokasi'],
        id: userMaps[0]['id'].toString(),
      );
    } else {
      // Return default empty user
      return User(
        nama: "",
        alamat: "",
        username: "",
        password: "",
        email: "",
        namaPerusahaan: "",
        deskipsiPerusahaan: "",
        nomor: "",
        lokasi: "",
      );
    }
  }

  Future<bool> register(User user) async {
    final List<Map<String, dynamic>> userMaps = await _database
        .query('users', where: 'username = ?', whereArgs: [user.username]);

    if (userMaps.isEmpty) {
      await _database.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cekUsername(String username) async {
    final List<Map<String, dynamic>> userMaps = await _database
        .query('users', where: 'username = ?', whereArgs: [username]);

    if (userMaps.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
*/
