import 'package:alquran_app/app/data/models/surah.dart';
import 'package:alquran_app/app/data/models/surah_detail.dart' as detail;
import 'package:alquran_app/app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  Map<String, dynamic>? bookmark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${Get.arguments["name"]}'),
        centerTitle: true,
      ),
      body: FutureBuilder<detail.SurahDetail>(
        future: controller.getDetailSurah(Get.arguments['number'].toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: green1,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('tidak ada data'),
            );
          }

          if (Get.arguments['bookmark'] != null) {
            bookmark = Get.arguments['bookmark'];
            if (bookmark!["index_ayat"] > 1) {
              controller.scrollC.scrollToIndex(bookmark!["index_ayat"] + 2,
                  preferPosition: AutoScrollPosition.begin);
            }
          }
          print(bookmark);

          detail.SurahDetail surah = snapshot.data!;

          List<Widget> allAyat = List.generate(
            snapshot.data?.verses?.length ?? 0,
            (index) {
              detail.Verse ayat = snapshot.data!.verses![index];
              return AutoScrollTag(
                key: ValueKey(index + 2),
                controller: controller.scrollC,
                index: index + 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
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
                                '${index + 1}',
                                style: TextStyle(
                                    color: white,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GetBuilder<DetailController>(
                            builder: (c) => Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        backgroundColor: white,
                                        title: 'BOOKMARK',
                                        titleStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: green1,
                                        ),
                                        middleText: 'Pilih Jenis Bookmark',
                                        middleTextStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                          color: green1,
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              c.addBookmark(true,
                                                  snapshot.data!, ayat!, index);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color(0xFF004225),
                                              ),
                                            ),
                                            child: Text(
                                              'Last Read',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: white,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              c.addBookmark(false,
                                                  snapshot.data!, ayat!, index);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color(0xFF004225),
                                              ),
                                            ),
                                            child: Text(
                                              'Bookmark',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: white,
                                              ),
                                            ),
                                          ),
                                        ]);
                                  },
                                  icon: Icon(
                                    Icons.bookmark_border,
                                    color: white,
                                  ),
                                ),
                                (ayat.verseCondition == 'stop')
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
                                          (ayat.verseCondition == 'play')
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
                      style:
                          const TextStyle(fontSize: 23, fontFamily: 'Poppins'),
                    ),
                    Text(
                      '${ayat.text?.transliteration?.en}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          color: Color(0xFF004225),
                          fontStyle: FontStyle.italic),
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
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          );

          return ListView(
            controller: controller.scrollC,
            padding: const EdgeInsets.all(20),
            children: [
              AutoScrollTag(
                key: ValueKey(0),
                controller: controller.scrollC,
                index: 0,
                child: GestureDetector(
                  onTap: () => Get.defaultDialog(
                    backgroundColor: white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    title: 'Tafsir Surah ${surah.name?.transliteration?.id}',
                    titleStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: green1,
                    ),
                    content: SizedBox(
                      height: Get.height * 0.8,
                      width: Get.width,
                      child: SingleChildScrollView(
                        child: Text(
                          '${surah.tafsir?.id}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: green1,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    width: Get.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: green1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 100,
                          top: -20,
                          child: SizedBox(
                            height: 180,
                            child: Opacity(
                              opacity: 0.2,
                              child: Image.asset(
                                'assets/images/calligraphy.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                '${surah.name?.transliteration?.id}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '( ${surah.name?.translation?.id} )',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            Text(
                              '${surah.numberOfVerses} Ayat | ${surah.revelation?.id}',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              AutoScrollTag(
                key: ValueKey(1),
                controller: controller.scrollC,
                index: 0,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              ...allAyat,
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: snapshot.data?.verses?.length ?? 0,
              //   itemBuilder: (context, index) {
              //     detail.Verse ayat = snapshot.data!.verses![index];

              //     return AutoScrollTag(
              //       key: ValueKey(index + 2),
              //       controller: controller.scrollC,
              //       index: index + 2,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           Container(
              //             width: Get.width,
              //             height: 50,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(15),
              //               color: green1,
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Container(
              //                   width: 50,
              //                   height: 50,
              //                   decoration: const BoxDecoration(
              //                     image: DecorationImage(
              //                       image: AssetImage(
              //                         'assets/images/number.png',
              //                       ),
              //                     ),
              //                   ),
              //                   child: Center(
              //                     child: Text(
              //                       '${index + 1}',
              //                       style: TextStyle(
              //                           color: white,
              //                           fontFamily: 'Poppins',
              //                           fontSize: 15,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ),
              //                 ),
              //                 GetBuilder<DetailController>(
              //                   builder: (c) => Row(
              //                     children: [
              //                       IconButton(
              //                         onPressed: () {
              //                           Get.defaultDialog(
              //                               backgroundColor: white,
              //                               title: 'BOOKMARK',
              //                               titleStyle: TextStyle(
              //                                 fontFamily: 'Poppins',
              //                                 fontSize: 16,
              //                                 fontWeight: FontWeight.bold,
              //                                 color: green1,
              //                               ),
              //                               middleText: 'Pilih Jenis Bookmark',
              //                               middleTextStyle: TextStyle(
              //                                 fontFamily: 'Poppins',
              //                                 fontSize: 16,
              //                                 // fontWeight: FontWeight.bold,
              //                                 color: green1,
              //                               ),
              //                               actions: [
              //                                 ElevatedButton(
              //                                   onPressed: () {
              //                                     c.addBookmark(
              //                                         true,
              //                                         snapshot.data!,
              //                                         ayat!,
              //                                         index);
              //                                   },
              //                                   style: ButtonStyle(
              //                                     backgroundColor:
              //                                         MaterialStateProperty.all<
              //                                             Color>(
              //                                       Color(0xFF004225),
              //                                     ),
              //                                   ),
              //                                   child: Text(
              //                                     'Last Read',
              //                                     style: TextStyle(
              //                                       fontFamily: 'Poppins',
              //                                       fontSize: 16,
              //                                       color: white,
              //                                     ),
              //                                   ),
              //                                 ),
              //                                 ElevatedButton(
              //                                   onPressed: () {
              //                                     c.addBookmark(
              //                                         false,
              //                                         snapshot.data!,
              //                                         ayat!,
              //                                         index);
              //                                   },
              //                                   style: ButtonStyle(
              //                                     backgroundColor:
              //                                         MaterialStateProperty.all<
              //                                             Color>(
              //                                       Color(0xFF004225),
              //                                     ),
              //                                   ),
              //                                   child: Text(
              //                                     'Bookmark',
              //                                     style: TextStyle(
              //                                       fontFamily: 'Poppins',
              //                                       fontSize: 16,
              //                                       color: white,
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ]);
              //                         },
              //                         icon: Icon(
              //                           Icons.bookmark_border,
              //                           color: white,
              //                         ),
              //                       ),
              //                       (ayat.verseCondition == 'stop')
              //                           ? IconButton(
              //                               onPressed: () {
              //                                 c.playAudio(ayat);
              //                               },
              //                               icon: Icon(
              //                                 Icons.play_arrow_rounded,
              //                                 color: white,
              //                               ),
              //                             )
              //                           : Row(
              //                               mainAxisSize: MainAxisSize.min,
              //                               children: [
              //                                 (ayat.verseCondition == 'play')
              //                                     ? IconButton(
              //                                         onPressed: () {
              //                                           // pause
              //                                           c.pauseAudio(ayat);
              //                                         },
              //                                         icon: Icon(
              //                                           Icons
              //                                               .pause_circle_filled_outlined,
              //                                           color: white,
              //                                         ),
              //                                       )
              //                                     : IconButton(
              //                                         onPressed: () {
              //                                           // play ulang
              //                                           c.resume(ayat);
              //                                         },
              //                                         icon: Icon(
              //                                           Icons
              //                                               .play_arrow_rounded,
              //                                           color: white,
              //                                         ),
              //                                       ),
              //                                 IconButton(
              //                                   onPressed: () {
              //                                     // matiin
              //                                     c.stop(ayat);
              //                                   },
              //                                   icon: Icon(
              //                                     Icons.stop_circle_rounded,
              //                                     color: white,
              //                                   ),
              //                                 ),
              //                               ],
              //                             )
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           Text(
              //             '${ayat.text?.arab}',
              //             style: const TextStyle(
              //                 fontSize: 23, fontFamily: 'Poppins'),
              //           ),
              //           Text(
              //             '${ayat.text?.transliteration?.en}',
              //             style: const TextStyle(
              //                 fontSize: 15,
              //                 fontFamily: 'Poppins',
              //                 color: Color(0xFF004225),
              //                 fontStyle: FontStyle.italic),
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           Text(
              //             '${ayat.translation?.id}',
              //             style: const TextStyle(
              //               fontSize: 15,
              //               fontFamily: 'Poppins',
              //             ),
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
            ],
          );
        },
      ),
    );
  }
}
