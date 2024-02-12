import 'package:alquran_app/app/data/models/juz.dart' as juz;
import 'package:alquran_app/app/data/models/surah.dart';
import 'package:alquran_app/app/routes/app_pages.dart';
import 'package:alquran_app/app/themes/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al-Quran'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GetBuilder<HomeController>(
                builder: (c) => FutureBuilder<Map<String, dynamic>?>(
                  future: c.getLastRead(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 150,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [green2, green1],
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: -65,
                                right: -15,
                                child: SizedBox(
                                  height: 250,
                                  child: Image.asset(
                                    'assets/images/read-quran.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: green1.withOpacity(
                                                    0.5), // Set the shadow color
                                                spreadRadius:
                                                    2, // Set the spread radius
                                                blurRadius:
                                                    2, // Set the blur radius
                                                offset: const Offset(
                                                  0, 2, // Set the offset
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/quran.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' ',
                                          style: TextStyle(
                                            color: green1,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Loading... ',
                                          style: TextStyle(
                                              color: green1,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          ' ',
                                          style: TextStyle(
                                              color: green1,
                                              fontFamily: 'Poppins',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    Map<String, dynamic>? lastRead = snapshot.data;

                    return Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onLongPress: () => c.deleteBookmark(lastRead!['id']),
                        onTap: () {
                          if (lastRead != null) {
                            Get.toNamed(
                              Routes.DETAIL,
                              arguments: {
                                'name': lastRead["surah"]
                                    .toString()
                                    .replaceAll("+", "'"),
                                'number': lastRead["number_surah"],
                                'bookmark': lastRead,
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 150,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [green2, green1],
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: -65,
                                right: -15,
                                child: SizedBox(
                                  height: 250,
                                  child: Image.asset(
                                    'assets/images/read-quran.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: green1.withOpacity(
                                                    0.5), // Set the shadow color
                                                spreadRadius:
                                                    2, // Set the spread radius
                                                blurRadius:
                                                    2, // Set the blur radius
                                                offset: const Offset(
                                                  0, 2, // Set the offset
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/quran.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Last Read',
                                          style: TextStyle(
                                            color: green1,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          lastRead == null
                                              ? ''
                                              : 'QS. ${lastRead!['surah'].replaceAll("+", "'")}',
                                          style: TextStyle(
                                              color: green1,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          lastRead == null
                                              ? ' '
                                              : 'Ayat ${lastRead!['ayat']}',
                                          style: TextStyle(
                                              color: green1,
                                              fontFamily: 'Poppins',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2,
                indicatorColor: green1,
                labelColor: green1,
                unselectedLabelColor: Colors.grey[400],
                tabs: const [
                  Tab(
                    child: Text(
                      'Surah',
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Bookmark',
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: green1,
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () => Get.toNamed(
                                  Routes.DETAIL,
                                  arguments: {
                                    'name': surah.name!.transliteration!.id,
                                    'number': surah.number,
                                  },
                                ),
                                leading: Container(
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
                                      '${surah.number}',
                                      style: TextStyle(
                                        color: green1,
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  '${surah.name?.transliteration?.id}',
                                  style: TextStyle(
                                      color: green1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                                subtitle: Text(
                                  '${surah.numberOfVerses} | ${surah.revelation?.id}',
                                  style: TextStyle(
                                      color: green1, fontFamily: 'Poppins'),
                                ),
                                trailing: Text(
                                  '${surah.name?.short}',
                                  style: TextStyle(
                                      color: green1,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    // FutureBuilder<List<juz.Juz>>(
                    //   future: controller.getAllJuz(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Center(
                    //         child: CircularProgressIndicator(
                    //           color: green1,
                    //         ),
                    //       );
                    //     }

                    //     if (!snapshot.hasData) {
                    //       return const Center(
                    //         child: Text('Tidak ada data'),
                    //       );
                    //     }

                    //     return ListView.builder(
                    //       shrinkWrap: true,
                    //       // physics: const NeverScrollableScrollPhysics(),
                    //       itemCount: snapshot.data?.length,
                    //       itemBuilder: (context, index) {
                    //         juz.Juz detailJuz = snapshot.data![index];

                    //         String nameStart =
                    //             detailJuz.juzStartInfo!.split(' - ').first;
                    //         String nameEnd =
                    //             detailJuz.juzEndInfo!.split(' - ').first;

                    //         List<Surah> rawSurahInJuz = [];
                    //         List<Surah> surahInJuz = [];

                    //         for (Surah item in controller.allSurah) {
                    //           rawSurahInJuz.add(item);
                    //           if (item.name!.transliteration!.id == nameEnd) {
                    //             break;
                    //           }
                    //         }

                    //         for (Surah item
                    //             in rawSurahInJuz.reversed.toList()) {
                    //           surahInJuz.add(item);
                    //           if (item.name!.transliteration!.id == nameStart) {
                    //             break;
                    //           }
                    //         }

                    //         return ListTile(
                    //           onTap: () => Get.toNamed(
                    //             Routes.DETAIL_JUZ,
                    //             arguments: {
                    //               'juz': detailJuz,
                    //               'surah': surahInJuz.reversed.toList(),
                    //             },
                    //           ),
                    //           leading: Container(
                    //             width: 50,
                    //             height: 50,
                    //             decoration: const BoxDecoration(
                    //               image: DecorationImage(
                    //                 image: AssetImage(
                    //                   'assets/images/number.png',
                    //                 ),
                    //               ),
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 '${index + 1}',
                    //                 style: TextStyle(
                    //                     color: green1,
                    //                     fontFamily: 'Poppins',
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 15),
                    //               ),
                    //             ),
                    //           ),
                    //           title: Text(
                    //             'Juz ${detailJuz.juz}',
                    //             style: TextStyle(
                    //                 color: green1, fontWeight: FontWeight.bold),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),

                    GetBuilder<HomeController>(
                      builder: (c) => FutureBuilder<List<Map<String, dynamic>>>(
                        future: c.getBookmark(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: green1,
                              ),
                            );
                          }

                          if (snapshot.data?.length == 0) {
                            return Center(
                              child: Text(
                                'Tidak ada Bookmark',
                                style: TextStyle(
                                  color: green1,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DETAIL,
                                    arguments: {
                                      'name': data["surah"]
                                          .toString()
                                          .replaceAll("+", "'"),
                                      'number': data["number_surah"],
                                      'bookmark': data,
                                    },
                                  );
                                },
                                leading: Container(
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
                                        color: green1,
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  '${data['surah'].toString().replaceAll("+", "'")}',
                                  style: TextStyle(
                                      color: green1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                                subtitle: Text(
                                  'Ayat ${data['ayat']} | Juz ${data['juz']}',
                                  style: TextStyle(
                                      color: green1, fontFamily: 'Poppins'),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    c.deleteBookmark(data['id']);
                                  },
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red[300],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
