import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: '뇌졸중 진단'),
      body: Center(
        child: PageView(
          // physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: pageController,
          children: [
            Container(
              color: Colors.amber,
              child: const Text('First Page'),
            ),
            const Text('Second Page'),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              );
            },
            child: const Icon(Icons.arrow_upward),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              );
            },
            child: const Icon(Icons.arrow_downward),
          ),
        ],
      ),
    );
  }
}
