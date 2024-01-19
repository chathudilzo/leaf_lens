
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class GeminiChatController extends GetxController{
  final gemini=Gemini.instance;
  RxString streamAnswer=''.obs;
  RxList<String> aoutputs=<String>[].obs;
  RxBool isLoading=false.obs;




  void geminiStream(String text)async{
    try{
      isLoading.value=true;
      gemini.streamGenerateContent(text).listen((event) {
        streamAnswer.value=event.output.toString();
      }).onError((error){
        streamAnswer.value=error;
      });
      isLoading.value=false;
    }catch(error){
      streamAnswer.value=error.toString();
      isLoading.value=false;
    }
  }

  
}