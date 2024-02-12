import 'package:alquran_app/app/data/models/juz.dart' as juz;
import 'package:alquran_app/app/data/models/surah.dart';
import 'package:alquran_app/app/themes/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments['juz'];
  final List<Surah> surahInJuz = Get.arguments['surah'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${detailJuz.juz.toString()}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: detailJuz.verses?.length ?? 0,
        itemBuilder: (context, index) {
          juz.Verses ayat = detailJuz.verses![index];
          if (index != 0) {
            if (ayat.number!.inSurah == 1) {
              controller.index++;
            }
          }

          return Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // const SizedBox(
                //   height: 10,
                // ),
                Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: green1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/number.png',
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${ayat.number!.inSurah}',
                                style: TextStyle(
                                  color: white,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '${surahInJuz[controller.index].name!.transliteration!.id}',
                            style: TextStyle(
                              color: white,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GetBuilder<DetailJuzController>(
                        builder: (c) => Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark_border,
                                color: white,
                              ),
                            ),
                            (ayat.kondisiAudio == 'stop')
                                ? IconButton(
                                    onPressed: () {
                                      c.playAudio(ayat);
                                    },
                                    icon: Icon(
                                      Icons.play_arrow_rounded,
                                      color: white,
                                    ),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (ayat.kondisiAudio == 'play')
                                          ? IconButton(
                                              onPressed: () {
                                                // pause
                                                c.pauseAudio(ayat);
                                              },
                                              icon: Icon(
                                                Icons
                                                    .pause_circle_filled_outlined,
                                                color: white,
                                              ),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                // play ulang
                                                c.resume(ayat);
                                              },
                                              icon: Icon(
                                                Icons.play_arrow_rounded,
                                                color: white,
                                              ),
                                            ),
                                      IconButton(
                                        onPressed: () {
                                          // matiin
                                          c.stop(ayat);
                                        },
                                        icon: Icon(
                                          Icons.stop_circle_rounded,
                                          color: white,
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${ayat.text?.arab}',
                  style: const TextStyle(fontSize: 23, fontFamily: 'Poppins'),
                ),
                Text(
                  '${ayat.text?.transliteration?.en}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    color: Color(0xFF004225),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${ayat.translation?.id}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
