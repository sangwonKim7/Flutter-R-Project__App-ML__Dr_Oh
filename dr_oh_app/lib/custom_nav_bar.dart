import 'package:dr_oh_app/view/home/home.dart';
import 'package:dr_oh_app/view/hospital/hospital.dart';
import 'package:dr_oh_app/view/mypage/mypage.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late int currentPageIndex;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    currentPageIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          // NavigationDestination(
          //   icon: Icon(Icons.content_paste),
          //   label: '문진',
          // ),
          NavigationDestination(
            icon: Icon(Icons.local_hospital),
            label: '병원',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.info_outline),
          //   label: '정보',
          // ),
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: '내 정보',
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
        animationDuration: const Duration(seconds: 2),
        height: 60,labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      body: <Widget>[
        // const Survey(),
        const Hospital(),
        const Home(),
        // const Information(),
        const MyPage(),
      ][currentPageIndex],
    );
  }
}
