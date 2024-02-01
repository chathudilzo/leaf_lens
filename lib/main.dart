import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leaf_lens/controllers/gemini_controller.dart';
import 'package:leaf_lens/pages/homepage.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';


void main()async {
  final dotenv=DotEnv();
    await dotenv.load(fileName: ".env");
    String APIKEY=dotenv.get('GEMINIAPIKEY');
    Gemini.init(apiKey: APIKEY);
  Get.put(GeminiChatController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      builder: (BuildContext context, child) =>GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:FlutterSplashScreen.gif(

  gifPath: 'assets/giphy.gif',
  gifWidth: 200.w,
  gifHeight: 200.w,  
  nextScreen: HomePage(),
  duration: const Duration(milliseconds: 5000),      
      ) ,
    ) ,
    );
  }
}
