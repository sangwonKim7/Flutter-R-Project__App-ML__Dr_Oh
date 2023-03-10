import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:dr_oh_app/view/information/info_bmi.dart';
import 'package:dr_oh_app/view/information/info_bmi_calc.dart';
import 'package:dr_oh_app/view/information/info_dementia.dart';
import 'package:dr_oh_app/view/information/info_diabetes.dart';
import 'package:dr_oh_app/view/information/info_stroke.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// --------------------------------------------------------------------
// Date: 2023-01-08, SangwonKim
// Desc: Information Page
class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: '정보'),
      // appBar: AppBar(
      //   title: const Text('INFORMATION'),
      //   elevation: 1,
      //   actions: const [LogoutBtn()],
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              // Date: 2023-01-08, SangwonKim
              // 당뇨병 정보 버튼
              _btn(const InfoDiabetes(), '당뇨병 정보', context),
              const SizedBox(
                height: 16,
              ),
              // Date: 2023-01-08, SangwonKim
              // 뇌졸중 정보 버튼
              _btn(const InfoStroke(), '뇌졸중 정보', context),
              const SizedBox(
                height: 16,
              ),
              // Date: 2023-01-08, SangwonKim
              // 치매 정보 버튼
              _btn(const InfoDementia(), '치매 정보', context),
              const SizedBox(
                height: 16,
              ),
              // Date: 2023-01-08, SangwonKim
              // BMI 정보 버튼
              _btn(const InfoBmi(), 'BMI 정보', context),
              const SizedBox(
                height: 16,
              ),
              // Date: 2023-01-08, SangwonKim
              // BMI 계산 버튼
              _btn(const InfoBmiCalc(), 'BMI 계산', context),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets ---
  // --------------------------------------------------------------------
  // Date: 2023-01-08, SangwonKim
  // Desc: 버튼 위젯
  _btn(dynamic page, String title, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(page);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: SizedBox(
        height: Get.height/100*13,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} // End
