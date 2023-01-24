import 'package:dr_oh_app/app.dart';
import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/stroke_bar_chart_widget.dart';

// ------------------------------------------------------------------------
// Date: 2023-01-10, SangwonKim
// Desc: 설문결과 페이지
class StrokeResultPage extends StatefulWidget {
  final String result;
  const StrokeResultPage({super.key, required this.result});

  @override
  State<StrokeResultPage> createState() => _StrokeResultPageState();
}

class _StrokeResultPageState extends State<StrokeResultPage> {
  late double result;

  @override
  void initState() {
    super.initState();
    result = double.parse(widget.result) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: '뇌졸중 예측 결과'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                // Date: 2023-01-11, SangwonKim
                // Desc: 위험도 카테고리별 텍스트 분류
                child: Text(
                  result >= 75
                      ? '위험'
                      : result >= 50
                          ? '주의'
                          : result >= 25
                              ? '관심'
                              : '안전',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: result >= 75
                          ? Colors.red
                          : result >= 50
                              ? Colors.orange
                              : result >= 25
                                  ? Colors.indigo
                                  : Colors.green
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  '${(double.parse(widget.result) * 100).round()}',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context)
                              .primaryColorLight
                              .withOpacity(0.5)),
                      child: Row(
                        children: [
                          Container(
                            width: double.parse(widget.result) * 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // Date: 2023-01-11, SangwonKim
                                // Desc: 위험도 카테고리별 색상분류
                                color: result >= 75
                                    ? Colors.red
                                    : result >= 50
                                        ? Colors.orange
                                        : result >= 25
                                            ? Colors.indigo
                                            : Colors.green
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    '100',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                result >= 75
                    ? '위험합니다. 빠른 시일 안에 병원에 방문해주세요!'
                    : result >= 50
                        ? '주의를 요합니다. 생활습관에 신경써주세요!'
                        : result >= 25
                            ? '관심을 가져주세요!'
                            : '안전합니다!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                    color: Colors.grey.shade700
                    // color:
                    ),
              ),
              const SizedBox(height: 16),
              // Date: 2023-01-11, SangwonKim
              // Desc: 연령대별 뇌졸중 위험도 차트
              const StrokeBarChartWidget(),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(const App());
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '처음으로',
                        style: TextStyle(
                          fontSize: 28,
                          // fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} // End
