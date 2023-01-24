import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:dr_oh_app/repository/localdata/user_repository.dart';
import 'package:flutter/material.dart';

class BodyInfo extends StatefulWidget {
  const BodyInfo({super.key});

  @override
  State<BodyInfo> createState() => _BodyInfoState();
}

class _BodyInfoState extends State<BodyInfo> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  bool correctheight = false;
  bool correctweight = false;

  // Desc: 신체정보 입력받는 TextField
  // Date: 2023-01-11
  // Widget _typeInfo(dynamic controller, String text) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 100, right: 100),
  //     child: TextField(
  //       controller: controller,
  //       keyboardType: const TextInputType.numberWithOptions(decimal: true),
  //       decoration: InputDecoration(
  //         hintText: text,
  //       ),
  //       onChanged: (value) {},
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: '신체정보 입력'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '신체정보 입력',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100, right: 100),
                      child: TextField(
                        controller: heightController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: '키(cm)',
                          labelText: correctheight ? '' : '키를 입력하세요',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              correctheight = true;
                            });
                          } else {
                            setState(() {
                              correctheight = false;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 100, right: 100),
                      child: TextField(
                        controller: weightController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: '몸무게(kg)',
                          labelText: correctweight ? '' : '몸무게를 입력하세요',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              correctweight = true;
                            });
                          } else {
                            setState(() {
                              correctweight = false;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: correctheight && correctweight
                            ? () {
                                UserRepository usrr = UserRepository();
                                usrr.addAction(heightController.text.trim(),
                                    weightController.text.trim());
                                _showDialog(context);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24))),
                        child: const Text(
                          '저장',
                          style: TextStyle(
                            fontSize: 28,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            title: const Text('입력 결과'),
            content: const Text(
              '입력이 완료되었습니다.',
            ),
            actions: [
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                }),
                child: const Text(
                  'OK',
                ),
              ),
            ],
          );
        }));
  }
}
