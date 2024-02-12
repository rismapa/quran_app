import 'dart:convert';

import 'package:alquran_app/app/data/db/bookmark.dart';
import 'package:alquran_app/app/data/models/juz.dart';
import 'package:alquran_app/app/data/models/surah.dart';
import 'package:alquran_app/app/themes/theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  List<Surah> allSurah = [];

  DatabaseManager database = DatabaseManager.instance;

  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await database.db;
    List<Map<String, dynamic>> dataLastRead = await db.query(
      "bookmark",
      where: "last_read = 1",
      orderBy: "surah",
    );

    if (dataLastRead.length == 0) {
      return null;
    } else {
      return dataLastRead.first;
    }
  }

  void deleteBookmark(int id) async {
    Database db = await database.db;

    await db.delete('bookmark', where: 'id = $id');
    update();
    Get.snackbar('Berhasil', 'Berhasil menghapus Bookmark', colorText: white);
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmarks =
        await db.query("bookmark", where: "last_read = 0");
    return allBookmarks;
  }

  Future<List<Surah>> getAllData() async {
    var response = await http.get(
      Uri.parse('https://api.quran.gading.dev/surah'),
    );
    List data = (jsonDecode(response.body) as Map<String, dynamic>)['data'];

    // maping
    if (data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  Future<List<Juz>> getAllJuz() async {
    List<Juz> allJuz = [];
    for (int i = 1; i <= 15; i++) {
      if (i == 5) {
        continue;
      }
      var response = await http.get(
        Uri.parse('https://api.quran.gading.dev/juz/$i'),
      );

      Map<String, dynamic> data =
          (jsonDecode(response.body) as Map<String, dynamic>)['data'];
      Juz juz = Juz.fromJson(data);

      allJuz.add(juz);
    }
    return allJuz;
  }
}
