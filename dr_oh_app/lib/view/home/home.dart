import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:dr_oh_app/components/news_api.dart';
import 'package:dr_oh_app/model/body_info_model.dart';
import 'package:dr_oh_app/model/name_model.dart';
import 'package:dr_oh_app/model/news_model.dart';
import 'package:dr_oh_app/view/home/all_checkup_history2.dart';
import 'package:dr_oh_app/view/home/body_info.dart';
import 'package:dr_oh_app/view/home/checkup_history.dart';
import 'package:dr_oh_app/view/survey/dementia_survey.dart';
import 'package:dr_oh_app/view/survey/diabetes_survey_page.dart';
import 'package:dr_oh_app/view/survey/stroke_survey_page.dart';
import 'package:dr_oh_app/viewmodel/checkup_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //** News API
  List<NewsModel> news = [];
  bool isLoading = true;
  NewsAPI newsAPI = NewsAPI();
  Future initNews() async {
    news = await newsAPI.getNews();
  }
  // News API */

  final CheckupHistoryViewModel _checkupHistoryViewModel =
      CheckupHistoryViewModel();
  late String id = '';

  // Desc: shared preferences 받기
  // Date: 2023-01-10
  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();

    _initSharedPreferences();
    initNews().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  // Desc: Calendar Date Picker
  // 검진기록이 있는 날짜 선택, 조회용
  // 2023-01-07, youngjin lee
  Widget _calendar() {
    DateTime selectedDate = DateTime.now();
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: CalendarDatePicker(
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            onDateChanged: ((value) {
              selectedDate = value;
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ElevatedButton(
            onPressed: () {
              Get.to(
                () => CheckupHistory(),
                arguments: selectedDate,
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '검진기록 조회',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // Desc: 홈화면 섹션 구분 박스
  // 2023-01-07, youngjin lee
  BoxDecoration _borderBox() {
    return BoxDecoration(
      border: Border.all(
        style: BorderStyle.none,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xFFAECCD6),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.5),
      //     spreadRadius: 1,
      //     blurRadius: 1,
      //   ),
      // ],
    );
  }

  Widget _sizedBox() {
    return const SizedBox(
      height: 10,
    );
  }

  // Desc: 각 박스 타이틀
  // Date: 2023-01-09
  Widget _head(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF99CD89),
      ),
      width: Get.width,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desc: 버튼 style
  Widget _button(dynamic path, String title) {
    return ElevatedButton(
      onPressed: () {
        Get.to(path);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // backgroundColor: Colors.
      ),
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desc: Health 카테고리 기사 헤드라인 (NewsAPI)
  // Date: 2023-01-09
  Widget _news() {
    return Container(
      decoration: _borderBox(),
      height: 180,
      width: 350,
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            )
          : Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          width: 180,
                          padding: const EdgeInsets.all(15),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AlertDialog(
                                          scrollable: true,
                                          title: Text(news[index].title),
                                          content:
                                              Text(news[index].description),
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    news[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                  ),
                                  Text(
                                    news[index].description,
                                    maxLines: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }

  // Desc: welcome 위젯 이름
  // Date: 2023-01-10
  Widget _getName(DocumentSnapshot doc) {
    final user = NameModel(name: doc['name']);
    return Text(
      '${user.name}님 건강한 하루 되세요!',
      style: const TextStyle(
        fontSize: 20,
        // fontWeight: FontWeight.bold,
      ),
    );
  }

  // Desc: 신체정보 받아오기
  // Date: 2023-01-11
  Widget _getBodyinfo(DocumentSnapshot doc) {
    final bodyinfo = doc.data().toString().contains('height')
        ? BodyInfoModel(
            id: doc['id'],
            height: doc['height'],
            weight: doc['weight'],
          )
        : BodyInfoModel(id: '', height: '', weight: '');
    return SizedBox(
      child: bodyinfo.height.toString().isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '   신체정보',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '키(${bodyinfo.height}cm), 몸무게(${bodyinfo.weight}kg)',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Get.to(const BodyInfo()),
                  icon: const Icon(Icons.edit),
                ),
                // Text(
                //   '몸무게 : ${bodyinfo.weight}kg',
                //   style: const TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
              ],
            )
          : Column(
              children: const [
                Text(
                  '입력된 신체정보가 없습니다.',
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: '홈'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: _borderBox(),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 32,
                        width: 240,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('id', isEqualTo: id)
                              .snapshots(),
                          builder: ((context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final documents = snapshot.data!.docs;

                            return ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children:
                                  documents.map((e) => _getName(e)).toList(),
                            );
                          }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.keyboard_double_arrow_down_rounded),
                          Text(
                            ' 진단하러 가기 ',
                            style: TextStyle(
                                color: Colors.grey[850],
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.keyboard_double_arrow_down_rounded),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () => Get.to(
                                  DiabetesSurveyPage(surveyName: '당뇨병 진단')),
                              child: Image.asset('images/diabetes.png')),
                          GestureDetector(
                              onTap: () => Get.to(
                                  StrokeSurveyPage(surveyName: '뇌졸중 진단')),
                              child: Image.asset('images/stroke.png')),
                          GestureDetector(
                              onTap: () => Get.to(
                                  DementiaSurvey()),
                              child: Image.asset('images/dementia.png')),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ),
              _sizedBox(),
              Container(
                decoration: _borderBox(),
                // height: 40,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    StreamBuilder(
                      stream: _checkupHistoryViewModel.stream,
                      builder: (context, snapshot) {
                        return Text(
                          '마지막 검진일: ${_checkupHistoryViewModel.date.toString().substring(0, 10)}',
                          style: const TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(const AllCheckupHistory2());
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.indigo,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.keyboard_double_arrow_right_rounded),
                            Text(
                              ' 전체기록 보기 ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.keyboard_double_arrow_left_rounded),
                          ],
                        )),
                  ],
                ),
              ),
              _sizedBox(),
              Container(
                decoration: _borderBox(),
                width: double.infinity,
                child: _calendar(),
              ),
              _sizedBox(),
              // _head('신체정보'),
              Container(
                decoration: _borderBox(),
                // height: 120,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('id', isEqualTo: id)
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final documents = snapshot.data!.docs;

                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children:
                                documents.map((e) => _getBodyinfo(e)).toList(),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    )
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 4,
                    //   ),
                    //   child: _button(
                    //     const BodyInfo(),
                    //     '입력 / 수정',
                    //   ),
                    // ),
                  ],
                ),
              ),
              // _sizedBox(),
              // _head('이력조회'),
              // const SizedBox(
              //   height: 3,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //         decoration: _borderBox(),
              //         width: 165,
              //         child: Column(
              //           children: [
              //             const Text(
              //               '최근 내원이력',
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             ElevatedButton(
              //               onPressed: () {
              //                 Get.to(HospitalVisit());
              //               },
              //               child: const Text(
              //                 '조회',
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         decoration: _borderBox(),
              //         width: 165,
              //         child: Column(
              //           children: [
              //             const Text(
              //               '최근 투약이력',
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             ElevatedButton(
              //               onPressed: () {
              //                 Get.to(const Medication());
              //               },
              //               child: const Text(
              //                 '조회',
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // _sizedBox(),
              // _head('뉴스'),
              // const SizedBox(
              //   height: 3,
              // ),
              // _news(),
            ],
          ),
        ),
      ),
    );
  }
}
