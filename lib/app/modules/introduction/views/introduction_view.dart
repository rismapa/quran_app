import 'package:alquran_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:get/get.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB7E5B4),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Al - Quran',
              style: TextStyle(
                color: Color(0xFF004225),
                fontFamily: 'Poppins',
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            const Text(
              'Setiap ayat adalah petunjuk, setiap langkah adalah pelajaran.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF004225),
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Lottie.asset('assets/lotties/intro-quran.json'),
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed(Routes.HOME),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004225),
                ),
                child: const Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
