
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class GeminiChatController extends GetxController{
  final gemini=Gemini.instance;
  RxString streamAnswer=''.obs;
  RxList<String> outputs=<String>[].obs;
  RxBool isLoading=false.obs;
  RxBool isGenerating=false.obs;



  void geminiStream(String text,VoidCallback scrollToBottom)async{
    try{
      isLoading.value=true;
      isGenerating.value=true;
      outputs.clear();

      await gemini.streamGenerateContent(text).forEach((event) {
        streamAnswer.value=event.output.toString();
        outputs.add(streamAnswer.value);
        isLoading.value=false;
        
      });
      scrollToBottom();
      isGenerating.value=false;
      isLoading.value=false;
    }catch(error){
      streamAnswer.value=error.toString();
      isLoading.value=false;
    }
  }

  
}