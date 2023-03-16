import 'dart:io';
import 'package:carezone/ui/disease_diagnosis_screen/ddd.dart';
import 'package:carezone/ui/resourses/Color_manager.dart';
import 'package:carezone/ui/resourses/styles_manager.dart';
import 'package:carezone/ui/resourses/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tflite/tflite.dart';

class DiseaseDiagosis extends StatefulWidget {
  const DiseaseDiagosis({super.key});
    @override


  @override
  State<DiseaseDiagosis> createState() => _DiseaseDiagosisState();
}

class _DiseaseDiagosisState extends State<DiseaseDiagosis> {

@override
  void initState() {
  loadMLModel();
    super.initState();
  }
  File? image;
  List? _output;
  Future pickImage(ImageSource src) async {
    try {
      final image = await ImagePicker().pickImage(source: src);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);

      runModelOnImage(File(image.path));

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  runModelOnImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5);
    setState(() {

      _output = output!;
    });
  }

  loadMLModel() async {
    await Tflite.loadModel(
        model: 'images/model_unquant.tflite', labels: 'images/labels.txt');
  }



@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( title: Text("Brain Tumor Detection",style: TextStyle(color: Colors.black87,fontSize: AppSize.s20)),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 26,
            color: ColorManager.black,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: AppSize.s4),
                width: MediaQuery.of(context).size.width,
                height: 170,



                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Let's start the diagnosis, upload the x-ray",
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton.icon(
                            icon: Icon(
                              Icons.image_outlined,
                              size: 35,
                              color: ColorManager.black,
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    const StadiumBorder()),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.teal)),
                            // color: Colors.blue,
                            label: const Text('Gallery',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal)),
                            onPressed: () {
                              pickImage(ImageSource.gallery);
                            }),
                        OutlinedButton.icon(
                            icon: Icon(
                              Icons.camera,
                              size: 35,
                              color: ColorManager.black,
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    const StadiumBorder()),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.teal)),
                            // color: Colors.blue,
                            label: const Text('Camera',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal)),
                            onPressed: () {
                              pickImage(ImageSource.camera);

                            }),
                      ],
                    ),
                  ],
                )),

            image == null ?  Center(child:Lottie.asset('images/100943-perulogy.json')) : Image.file(image!),
            SizedBox(
              height:AppSize.s20,
            ),
            _output == null ? Text("") : Container(color: Colors.grey[200],child: Text("${_output![0]["label"]}",style: getRegularStyle(fontSize: AppSize.s32,color: Colors.black87),)),
          ],
        ),
      ),
    );
  }
}
