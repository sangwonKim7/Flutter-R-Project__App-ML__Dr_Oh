import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/model/bmi_message.dart';
import 'package:dr_oh_app/view/information/info_bmi_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --------------------------------------------------------------------
// Date: 2023-01-08, SangwonKim
// Desc: Information / BMI Calculator
class InfoBmiCalc extends StatefulWidget {
  const InfoBmiCalc({super.key});

  @override
  State<InfoBmiCalc> createState() => _InfoBmiCalcState();
}

class _InfoBmiCalcState extends State<InfoBmiCalc> {
  late int numAge; // 나이
  late int numWeight; // 몸무게
  late int numHeight; // 키
  late bool switchGender; // 성별
  late double bmiResult; // BMI 결과
  late String bmiResultStr; // BMI 분류결과
  late String bmiResultContent; // BMI 분류결과 별 내용
  late String bmiResultImage; // BMI 분류결과 별 이미지

  @override
  void initState() {
    super.initState();
    numAge = 30; // 나중에 사용자 정보 가져오기 <<
    numWeight = 70; // 나중에 사용자 정보 가져오기 <<
    numHeight = 170; // 나중에 사용자 정보 가져오기 <<
    switchGender = false; // 나중에 사용자 정보 가져오기 <<
    bmiResult = 0;
    bmiResultStr = '';
    bmiResultContent = '';
    bmiResultImage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: 'BMI 계산'),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width / 100 * 44,
                      height: Get.height / 100 * 28,
                      // width: 194,
                      // height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '나이',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            numAge.toString(),
                            style: const TextStyle(fontSize: 80),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                elevation: 0,
                                heroTag: 'btn1',
                                onPressed: () {
                                  minusAge();
                                },
                                backgroundColor:
                                    // Theme.of(context).primaryColorDark,
                                    const Color.fromARGB(255, 96, 139, 109),
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.remove,
                                  size: 36,
                                ),
                              ),
                              FloatingActionButton(
                                elevation: 0,
                                heroTag: 'btn2',
                                onPressed: () {
                                  plusAge();
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 96, 139, 109),
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.add,
                                  size: 36,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Container(
                      width: Get.width / 100 * 44,
                      height: Get.height / 100 * 28,
                      // width: 194,
                      // height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '몸무게',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            numWeight.toString(),
                            style: const TextStyle(fontSize: 80),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                elevation: 0,
                                heroTag: 'btn3',
                                onPressed: () {
                                  minusWeight();
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 96, 139, 109),
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.remove,
                                  size: 36,
                                ),
                              ),
                              FloatingActionButton(
                                elevation: 0,
                                heroTag: 'byn4',
                                onPressed: () {
                                  plusWeight();
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 96, 139, 109),
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.add,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width / 100 * 92,
                height: Get.height / 100 * 24,
                // width: 404,
                // height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      '키',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      numHeight.toString(),
                      style: const TextStyle(fontSize: 80),
                    ),
                    Slider(
                      value: numHeight.toDouble(),
                      min: 80,
                      max: 200,
                      divisions: 120,
                      activeColor: const Color.fromARGB(255, 96, 139, 109),
                      label: numHeight.round().toStringAsFixed(0),
                      onChanged: (double value) {
                        setState(() {
                          numHeight = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: Get.width / 100 * 92,
                height: Get.height / 100 * 14,
                // width: 404,
                // height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      '성별',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        const Text(
                          '남성',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: switchGender,
                          activeColor: Colors.transparent,
                          onChanged: (value) {
                            onClickedGender();
                          },
                        ),
                        const Text(
                          '여성',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  checkBmi();
                  BmiMessage.bmiResult = bmiResult;
                  _saveResult(bmiResult);
                  Get.to(const InfoBmiResult());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: SizedBox(
                  width: Get.width / 100 * 92,
                  height: Get.height / 100 * 10,
                  // height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '계산',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
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

  // --- Functions ---

  _saveResult(double result) async {
    // SharedPreferences를 통해 로그인한 사용자 id 가져오기
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id')!;
    String date = DateTime.now().toString().substring(0, 10);

    // Stroke 데이타 업데이트하기
    FirebaseFirestore.instance
        .collection('result')
        .add({'result': result, 'userid': id, 'date': date, 'category': 'BMI'});
  }

  // --------------------------------------------------------------------
  // Date: 2023-01-08, SangwonKim
  // Desc: 계산하는 함수들
  // 나이 +
  plusAge() {
    setState(() {
      numAge++;
    });
  }

  // 나이 -
  minusAge() {
    setState(() {
      numAge--;
    });
  }

  // 몸무게 +
  plusWeight() {
    setState(() {
      numWeight++;
    });
  }

  // 몸무게 -
  minusWeight() {
    setState(() {
      numWeight--;
    });
  }

  // 성별 확인
  onClickedGender() {
    setState(() {
      if (switchGender == true) {
        switchGender = false;
      } else {
        switchGender = true;
      }
    });
  }

  // --------------------------------------------------------------------
  // Date: 2023-01-08, SangwonKim
  // Desc: BMI지수 계산, 결과 별 카테고리 항목 저장하기
  checkBmi() {
    bmiResult = double.parse(
        (numWeight / (numHeight * numHeight) * 10000).toStringAsFixed(1));
    if (bmiResult < 18.5) {
      bmiResultStr = 'UnderWeight';
      bmiResultContent =
          '저체중이라고 해도 대체로 건강한 상태이지만\n영양부족의 위험성이 있음\n평소 건강 상의 문제가 없으나 영양부족의 이유로\n몸이 허약하고, 체력이 약함\n빈혈이 있다면 정기적으로 건강검진을 해보는 것을 추천';
      if (switchGender == false) {
        bmiResultImage = 'images/underweight_male.png';
      } else {
        bmiResultImage = 'images/underweight_female.png';
      }
    } else if (bmiResult <= 24.9) {
      bmiResultStr = 'Normal Weight';
      bmiResultContent = '건강한 상태\n이 상태를 유지하기를 추천';
      if (switchGender == false) {
        bmiResultImage = 'images/normalweight_male.png';
      } else {
        bmiResultImage = 'images/normalweight_female.png';
      }
    } else if (bmiResult <= 29.9) {
      bmiResultStr = 'OverWeight';
      bmiResultContent = '건강함\n혹은 건강문제가 조금씩 증가하는 단계';
      if (switchGender == false) {
        bmiResultImage = 'images/overweight_male.png';
      } else {
        bmiResultImage = 'images/overweight_female.png';
      }
    } else if (bmiResult <= 39.9) {
      bmiResultStr = 'Obesity';
      bmiResultContent = '건강상태 나빠질 우려 있음\n조심해야 하는 단계';
      if (switchGender == false) {
        bmiResultImage = 'images/obesity_male.png';
      } else {
        bmiResultImage = 'images/obesity_female.png';
      }
    } else {
      bmiResultStr = 'Extreme Obesity';
      bmiResultContent =
          '건강 상태가 위험한 단계\n고혈압, 당뇨, 암 등의 질병 발병 가능성이 높음\n정기적으로 건강검진이 필요한 대상';
      if (switchGender == false) {
        bmiResultImage = 'images/extremeobesity_male.png';
      } else {
        bmiResultImage = 'images/extremeobesity_female.png';
      }
    }
    BmiMessage.bmiResultStr = bmiResultStr;
    BmiMessage.bmiResultContent = bmiResultContent;
    BmiMessage.bmiResultImage = bmiResultImage;
  }
} // End
