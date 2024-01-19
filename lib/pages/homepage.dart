import 'package:flutter/material.dart';
import 'package:leaf_lens/controllers/gemini_controller.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

GeminiChatController chatController=Get.find();
TextEditingController inputController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx((){
            if(chatController.isLoading.value){
              return const CircularProgressIndicator();
            }else if(chatController.streamAnswer==''){
              return Center(
                child: Column(
                  children: [
                    TextField(
                  controller: inputController,
                ),
                TextButton(onPressed: (){
                  chatController.geminiStream(inputController.text);
                }, child: Text('Submit'))
                  ],
                )
              );
            }else{
              return Text(chatController.streamAnswer.toString());
            }
          }),
        ],
      ),
    );
  }
}