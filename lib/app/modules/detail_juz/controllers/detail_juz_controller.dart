import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:alquran_app/app/data/models/juz.dart';

class DetailJuzController extends GetxController {
  int index = 0;

  final player = AudioPlayer();

  Verses? latestVerse;

  void playAudio(Verses? ayat) async {
    if (ayat?.audio?.primary != null) {
      try {
        if (latestVerse == null) {
          latestVerse = ayat;
        }
        latestVerse!.kondisiAudio = 'stop';
        latestVerse = ayat;
        update();

        await player.stop();
        await player.setUrl(ayat!.audio!.primary!);
        ayat.kondisiAudio = 'play';
        update();
        await player.play();
        ayat.kondisiAudio = 'stop';
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

  void pauseAudio(Verses ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = 'pause';
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

  void resume(Verses ayat) async {
    try {
      ayat.kondisiAudio = 'play';
      update();
      await player.play();
      ayat.kondisiAudio = 'stop';
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

  void stop(Verses ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = 'stop';
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
