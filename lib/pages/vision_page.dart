import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf_lens/controllers/gemini_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VisionPage extends StatefulWidget {
  const VisionPage({super.key});

  @override
  State<VisionPage> createState() => _VisionPageState();
}

class _VisionPageState extends State<VisionPage> {
XFile? image;
GeminiChatController controller=Get.find();
TextEditingController textController=TextEditingController();

  Future<void> pickImage()async{
   try{
    print('tapped');
                  final ImagePicker picker=ImagePicker();
                  final img=await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    image=img;
                  });
      

   }catch(error){
    print(error);
   }

  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 375.w,
      height: 812.h,
      //color: Colors.amber,

      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h,),
            Container(
              width: 200.w,
              height: 200.w,
              
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                
                borderRadius: BorderRadius.circular(15.w)
              ),
              child:image!=null
              ?ClipRRect(child: Image(image: FileImage(File(image!.path),),fit: BoxFit.cover,),borderRadius: BorderRadius.circular(10.w),)
              :ClipRRect(child: Image(image: AssetImage('assets/imgsearch.jpeg')),borderRadius: BorderRadius.circular(50.w),),
            ),
      
            // Container(
            //   margin: EdgeInsets.only(bottom: 20,top: 20),
            //   width: 300.w,
            // height: 50.h,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(15.w),
            //   gradient: LinearGradient(colors: [Colors.blueAccent,Colors.orangeAccent])
            // ),),
            SizedBox(height: 100.h,),
            Obx((){
              if(controller.isLoading.value){
                return LoadingAnimationWidget.staggeredDotsWave(color: Colors.blueAccent, size: 50);
              }else{
                return Container(
              width: 300.w,
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w),
                color: const Color.fromARGB(255, 34, 34, 34),
                boxShadow: [BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset:Offset(1, 2)
                )]
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 200.w,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: textController,
                                  decoration: InputDecoration(
                                    hintText: 'Ask about the image',
                                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                                  ),
                                ),
                  ),
                IconButton(onPressed: ()async{
                  pickImage();
                }, icon: Icon(Icons.image,color: Colors.blueAccent,)),
                IconButton(onPressed: (){
                  if(image!=null && textController.text!=''){
                        controller.geminiVisionResponse(textController.text, image!);
      }
                }, icon: Icon(Icons.send),color: Colors.greenAccent,)
                ],
              )
            );
              }
            }),
            Obx((){
              if(controller.isLoading.value){
                return Container();
              }else{
                return Container(
              //color: Colors.green,
              padding: EdgeInsets.all(8.w),
              width: 300.w,
              
              child: Text(controller.streamAnswer.toString(),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
            );
              }
            })
          ],
        ),
      ),
    );

  }
}