import 'dart:convert';
import 'dart:ffi';

import 'package:alquran_app/app/data/db/bookmark.dart';
import 'package:alquran_app/app/data/models/juz.dart';
import 'package:alquran_app/app/data/models/surah_detail.dart';
import 'package:alquran_app/app/modules/home/controllers/home_controller.dart';
import 'package:alquran_app/app/themes/theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class DetailController extends GetxController {
  RxString condition = 'stop'.obs;

  AutoScrollController scrollC = AutoScrollController();

  final homeC = Get.find<HomeController>();

  final player = AudioPlayer();

  Verse? latestVerse;

  DatabaseManager database = DatabaseManager.instance;

  void addBookmark(
      bool lastRead, SurahDetail surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete('bookmark', where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          where:
              "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "+")}' AND number_surah = ${surah.number!} AND ayat = ${ayat.number!.inSurah} AND juz = ${ayat.meta!.juz} AND via = 'surah' AND index_ayat = $indexAyat AND last_read = 0");

      if (checkData.length != 0) {
        // ada data
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert(
        "bookmark",
        {
          "surah": "${surah.name!.transliteration!.id!.replaceAll("'", "+")}",
          "number_surah": surah.number!,
          "ayat": ayat.number!.inSurah,
          "juz": ayat.meta!.juz,
          "via": "surah",
          "index_ayat": indexAyat,
          "last_read": lastRead == true ? 1 : 0,
        },
      );

      Get.back();
      homeC.update();
      Get.snackbar('Berhasil', "Berhasil menambahkan bookmark",
          colorText: white);
    } else {
      Get.back();
      Get.snackbar('Terjadi Kesalahan', "Data sudah disimpan",
          colorText: white);
    }
    var data = await db.query('bookmark');
    print(data);
  }

  Future<SurahDetail> getDetailSurah(String id) async {
    var response = await http.get(
      Uri.parse('https://api.quran.gading.dev/surah/${id}'),
    );

    Map<String, dynamic> data =
        (jsonDecode(response.body) as Map<String, dynamic>)['data'];

    return SurahDetail.fromJson(data);
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      try {
        if (latestVerse == null) {
          latestVerse = ayat;
        }
        latestVerse!.verseCondition = 'stop';
        latestVerse = ayat;
        update();

        await player.stop();
        await player.setUrl(ayat!.audio!.primary!);
        ayat.verseCondition = 'play';
        update();
        await player.play();
        ayat.verseCondition = 'stop';
        update();
        await player.stop();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: 'Error',
          middleText: '${e.message}',
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: 'Error',
          middleText: '${e.message}',
        );
      } catch (e) {
        Get.defaultDialog(
          title: 'Error',
          middleText: '${e}',
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Url tidak ditemukan',
      );
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.verseCondition = 'pause';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e.message}',
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e.message}',
      );
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e}',
      );
    }
  }

  void resume(Verse ayat) async {
    try {
      ayat.verseCondition = 'play';
      update();
      await player.play();
      ayat.verseCondition = 'stop';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e.message}',
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e.message}',
      );
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e}',
      );
    }
  }

  void stop(Verse ayat) async {
    try {
      await player.stop();
      ayat.verseCondition = 'stop';
      await player.stop();
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e.message}',
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e.message}',
      );
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '${e}',
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
