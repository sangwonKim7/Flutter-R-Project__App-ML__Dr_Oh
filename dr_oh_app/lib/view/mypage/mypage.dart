import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:dr_oh_app/model/user.dart';
import 'package:dr_oh_app/repository/localdata/user_repository.dart';
import 'package:dr_oh_app/view/mypage/bmi_chart_record.dart';
import 'package:dr_oh_app/view/mypage/dementia_chart_record.dart';
import 'package:dr_oh_app/view/mypage/diabetes_chart_record.dart';
import 'package:dr_oh_app/view/mypage/edit_member_info.dart';
import 'package:dr_oh_app/view/mypage/sign_out.dart';
import 'package:dr_oh_app/view/mypage/stroke_chart_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Date: 2023-01-08, jyh
// 화면구성중
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String id = '';
  Widget _head(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).primaryColor,
      ),
      width: Get.width,
      height: 44,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profile(String name, String gender, String birthdate, String email) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 35,
                  child: TextButton(
                      onPressed: () async {
                        UserRepository usrr = UserRepository();
                        UserModel usr = await usrr.getUserInfo();
                        Get.to(EditMemberInfo(user: usr));
                      },
                      child: const Icon(Icons.settings)),
                ),
              ],
            ),
            const Divider(thickness: 0.5, height: 1, color: Colors.grey),
            const SizedBox(height: 10),
            _profileContent('이름', name, 4.1),
            const SizedBox(height: 10),
            const Divider(thickness: 0.5, height: 1, color: Colors.grey),
            const SizedBox(height: 10),
            _profileContent('성별', gender, 4.1),
            const SizedBox(height: 10),
            const Divider(thickness: 0.5, height: 1, color: Colors.grey),
            const SizedBox(height: 10),
            _profileContent('생년월일', birthdate, 6.1),
            const SizedBox(height: 10),
            const Divider(thickness: 0.5, height: 1, color: Colors.grey),
            const SizedBox(height: 10),
            _profileContent('이메일', email, 4.8),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _profileContent(String title, String content, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: Get.width / width),
        Text(
          content,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _userInfo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      width: Get.width,
      child: Column(
        children: <Widget>[
          // _btnContentActions(
          //   "즐겨찾기한 병원",
          //   const Icon(
          //     Icons.local_hospital,
          //     color: Color(0xFF99CD89),
          //   ),
          //   const SignOut(),
          // ),
          // const Divider(),
          // _btnContentActions(
          //   "내가 쓴 글",
          //   const Icon(
          //     Icons.payment,
          //     color: Color(0xFF99CD89),
          //   ),
          //   const SignOut(),
          // ),
          // const Divider(),
          _btnContentActions(
            "회원 탈퇴",
            Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
              size: 36,
            ),
            const SignOut(),
          ),
        ],
      ),
    );
  }

  Widget _additionalInfo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      // width: Get.width,
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _btnContentActions(
            "당뇨병 차트 기록",
            const Icon(
              Icons.bar_chart,
              color: Colors.red,
              size: 36,
            ),
            // 2023-01-13, SangwonKim
            // Desc: 당뇨병 차트 기록으로 가기
            const DiabetesChartRecord(),
          ),
          const Divider(),
          _btnContentActions(
            "뇌졸중 차트 기록",
            const Icon(
              Icons.show_chart,
              color: Colors.green,
              size: 36,
            ),
            // 2023-01-13, SangwonKim
            // Desc: 뇌졸중 차트 기록으로 가기
            const StrokeChartRecord(),
          ),
          const Divider(),
          _btnContentActions(
            "치매 차트 기록",
            const Icon(
              Icons.area_chart,
              color: Colors.blue,
              size: 36,
            ),
            // 2023-01-13, SangwonKim
            // Desc: 뇌졸중 차트 기록으로 가기
            const DementiaChartRecord(),
          ),
          const Divider(),
          _btnContentActions(
            "BMI 차트 기록",
            const Icon(
              Icons.pie_chart,
              color: Colors.deepPurple,
              size: 36,
            ),
            // 2023-01-13, SangwonKim
            // Desc: BMI 차트 기록으로 가기
            const BmiChartRecord(),
          ),
        ],
      ),
    );
  }

  Widget _btnContentActions(String text, Icon icon, dynamic path) {
    return
    ListTile(
      leading: icon,
      title: Text(
        "  $text",
        style: const TextStyle(fontSize: 20),
      ),
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      // visualDensity: VisualDensity(vertical: -3)
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 24,
        color: Colors.brown,
      ),
      onTap: () {
        Get.to(path);
      },
    );
  }

  // Desc: 회원정보 가져오기
  Widget _getMemberInfo(DocumentSnapshot doc) {
    final user = UserModel(
      name: doc['name'],
      gender: doc['gender'],
      birthdate: doc['birthdate'],
      email: doc['email'],
    );
    return _profile(user.name.toString(), user.gender.toString(),
        user.birthdate.toString(), user.email.toString());
  }

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getString('id') ?? "");
    });
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: '내 정보'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          children: [
            _head('기본정보'),
            SizedBox(
              height: 210,
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
                    children: documents.map((e) => _getMemberInfo(e)).toList(),
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),
            _head('추가정보'),
            _additionalInfo(),
            const SizedBox(height: 2),
            Divider(
              height: 20,
              color: Theme.of(context).primaryColor,
              thickness: 3,
              indent: 8,
              endIndent: 8,
            ),
            const SizedBox(height: 2),
            _userInfo(),
            const SizedBox(height: 4),
            Text(
              "Dr. Oh",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Version 0.0.1",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
