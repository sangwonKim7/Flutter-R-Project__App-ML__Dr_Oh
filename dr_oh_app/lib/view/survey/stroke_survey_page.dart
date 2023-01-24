import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:dr_oh_app/components/stroke_answer_list.dart';
import 'package:dr_oh_app/model/stroke_model.dart';
import 'package:dr_oh_app/view/survey/stroke_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/stroke_message.dart';
import '../../repository/localdata/stroke_predict.dart';

// Date: 2023-01-10, SangwonKim
// Desc: 뇌졸중 검사 페이지
class StrokeSurveyPage extends StatelessWidget {
  final PageController _surveyController = PageController(initialPage: 0);

  StrokeSurveyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: '뇌졸중 진단'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        // Date: 2023-01-10, SangwonKim
        // Desc: Firebase에서 설문질문 가져오기 위젯
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '문진표',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            // Date: 2023-01-10, SangwonKim
            // Desc: DB(Firebase)에서 질문목록오기
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Stroke')
                  .orderBy('seq', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final documents = snapshot.data!.docs;
                return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 100 * 64,
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    controller: _surveyController,
                    children: documents
                        .map((index) => _buildItemWidget(index, context))
                        .toList(),
                  ),
                );
              },
            ),

            // Date: 2023-01-11, SangwonKim
            // Desc: 진단 버튼 누르기 -> Rserve로 보내서 머신러닝 실행
            Row(
              children: [
                SizedBox(
                  width: 228,
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (StrokeMessage.hypertension == '' ||
                          StrokeMessage.heartDisease == '' ||
                          StrokeMessage.everMarried == '' ||
                          StrokeMessage.workType == '' ||
                          StrokeMessage.residenceType == '' ||
                          StrokeMessage.smoke == '') {
                        Get.snackbar(
                          '안내',
                          '문진답변을 확인해주세요',
                          backgroundColor: Colors.redAccent,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 2),
                        );
                      } else {
                        // Desc: Rserve로 보내서 머신러닝 실행
                        StrokePredict predict = StrokePredict();
                        String result = await predict.predict(
                          StrokeMessage.sex,
                          StrokeMessage.age,
                          StrokeMessage.height,
                          StrokeMessage.weight,
                          int.parse(StrokeMessage.hypertension),
                          int.parse(StrokeMessage.heartDisease),
                          int.parse(StrokeMessage.everMarried),
                          int.parse(StrokeMessage.workType),
                          int.parse(StrokeMessage.residenceType),
                          int.parse(StrokeMessage.smoke),
                        );
                        // 설문페이지로 안돌아오게 설정
                        Get.off(StrokeResultPage(result: result));
                        // Date: 2023-01-11, SangwonKim
                        // Desc: 사용자의 설문 입력값 초기값으로 설정해주기
                        StrokeMessage.hypertension = '';
                        StrokeMessage.heartDisease = '';
                        StrokeMessage.everMarried = '';
                        StrokeMessage.workType = '';
                        StrokeMessage.residenceType = '';
                        StrokeMessage.smoke = '';
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '진단',
                          style: TextStyle(
                            fontSize: 28,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 60)
              ],
            ),
            const SizedBox(height: 8)
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: FloatingActionButton(
              heroTag: '1',
              backgroundColor: Theme.of(context).primaryColorDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onPressed: () {
                // _surveyController.animateToPage(index+1, duration: duration, curve: curve)
                _surveyController.previousPage(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                size: 36,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            height: 60,
            child: FloatingActionButton(
              heroTag: '2',
              backgroundColor: Theme.of(context).primaryColorDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onPressed: () {
                _surveyController.nextPage(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widgets ---

  // ------------------------------------------------------------------------
  // Date: 2023-01-10, SangwonKim
  // Desc: StrokeModel에서 질문목록 가져오기 위젯
  Widget _buildItemWidget(DocumentSnapshot doc, BuildContext ctx) {
    final strokeModel = StrokeModel(seq: doc['seq'], question: doc['question']);
    // 답변목록 가져오기
    StrokeAnswerList answer = StrokeAnswerList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Card(
            elevation: 4,
            shadowColor: Colors.grey[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Theme.of(ctx).primaryColorLight,
            child: ListTile(
              title: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    '${strokeModel.seq}. ${strokeModel.question}',
                    style: TextStyle(
                      color: Colors.blueGrey.shade800,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      height: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 200),
                  answer.strokeAnswerList[strokeModel.seq - 1],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  } // _buildItemWidget

  

} // End

class CustomTextStyle {
  static const TextStyle surveyTextStyle = TextStyle(
    fontSize: 24,
    // color: Colors.green,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle surveyTitleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold
  );
}