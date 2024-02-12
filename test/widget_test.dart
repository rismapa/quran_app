import 'dart:convert';

import 'package:alquran_app/app/data/models/ayat.dart';
import 'package:alquran_app/app/data/models/juz.dart';
import 'package:alquran_app/app/data/models/surah.dart';
import 'package:alquran_app/app/data/models/surah_detail.dart';
import 'package:http/http.dart' as http;

void main() async {
  var response =
      await http.get(Uri.parse('https://api.quran.gading.dev/surah/1'));

  Map<String, dynamic> data =
      (jsonDecode(response.body) as Map<String, dynamic>)['data'];

  print(data);

  // tes juz
  // Future<List<Juz>> getAllJuz() async {
  // List<Juz> allJuz = [];
  // // for (int i = 1; i <= 30; i++) {
  // var response = await http.get(
  //   Uri.parse('https://api.quran.gading.dev/juz/5'),
  // );

  // Map<String, dynamic> data =
  //     (jsonDecode(response.body) as Map<String, dynamic>)['data'];

  // Juz juz = Juz.fromJson(data);
  // print(juz.juz);

  // allJuz.add(juz);
  // }

  // allJuz.forEach((e) {
  //   print(e.toJson());
  // });

  // tes ayat
  // var response = await http.get(
  //   Uri.parse('https://api.quran.gading.dev/surah/114/1'),
  // );

  // Map<String, dynamic> data =
  //     (jsonDecode(response.body) as Map<String, dynamic>)['data'];

  // // masukin ke model
  // Ayat ayat = Ayat.fromJson(data);
  // print(ayat.tafsir?.id?.short);

  // Future<SurahDetail> getDetailSurah(String id) async {
  //   var response = await http.get(
  //     Uri.parse('https://api.quran.gading.dev/surah/${id}'),
  //   );

  //   Map<String, dynamic> data =
  //       (jsonDecode(response.body) as Map<String, dynamic>)['data'];

  //   SurahDetail test = SurahDetail.fromJson(data);
  //   print(test.name);

  //   return SurahDetail.fromJson(data);
  // }

  // await getDetailSurah(1.toString());
  // var resp = await http.get(Uri.parse('https://api.quran.gading.dev/surah'));

  // // Ini kan hasilnya String -> dynamic -> Map
  // List data = (jsonDecode(resp.body) as Map<String, dynamic>)['data'];

  // // Terus dari raw data ini ubah ke bentuk Model
  // Surah annas = Surah.fromJson(data[113]);

  // Test Detail Surah
  // var response =
  //     await http.get(Uri.parse('https://api.quran.gading.dev/surah/114'));

  // // dari string -> map biar bisa ambil datanya
  // Map<String, dynamic> dataAnnas =
  //     (jsonDecode(response.body) as Map<String, dynamic>)['data'];

  // // Ubah ke bentuk model biar gampang diambilnya
  // SurahDetail detailAnnas = SurahDetail.fromJson(dataAnnas);

  // print(detailAnnas.verses[0].text.arab);
}
