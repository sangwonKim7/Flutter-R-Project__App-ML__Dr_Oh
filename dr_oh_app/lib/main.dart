import 'package:dr_oh_app/components/color_service.dart';
import 'package:dr_oh_app/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';

import 'binding/init_bindings.dart';
import 'firebase_options.dart';

void main() async {
  // Date: 2023-01-09, jyh
  // firebase 연동
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        // Date: 2023-01-07, SangwonKim
        // 프라이머리 스와치 컬러 : figma > primary-진하게 > colorcode: 5B9D46
        // Update Date: 2023-01-08, SangwonKim
        // color code 변경: primary > 99CD89
        primarySwatch:
            ColorService.createMaterialColor(const Color(0xFF3A5A65)),
        // ColorService.createMaterialColor(const Color(0xFF99CD89)),
        primaryColorDark: const Color(0xFF2A2F49),
        // primaryColorDark: const Color(0xFF5B9D46),
        primaryColorLight: const Color(0xFFAECCD6),
        // Date: 2023-01-07, SangwonKim
        // Desc: app바 테마 설정
        appBarTheme: AppBarTheme(
          color: Colors.grey[50],
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 224, 226, 227),
        navigationBarTheme: NavigationBarThemeData(
          // backgroundColor: Colors.grey[400],
          indicatorColor: const Color(0xFF3A5A65).withOpacity(0.5)
        ),
      ),
      darkTheme: ThemeData.dark(),
      initialBinding: InitBinding(),
      home: const Login(),
    );
  }
}
