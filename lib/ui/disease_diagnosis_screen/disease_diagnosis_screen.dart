import 'dart:io';

import 'package:carezone/ui/resourses/Color_manager.dart';
import 'package:carezone/ui/resourses/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseDiagosis extends StatefulWidget {
  const DiseaseDiagosis({super.key});

  @override
  State<DiseaseDiagosis> createState() => _DiseaseDiagosisState();
}

class _DiseaseDiagosisState extends State<DiseaseDiagosis> {
  File? image;
  Future pickImage(ImageSource src) async {
    try {
      final image = await ImagePicker().pickImage(source: src);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                height: 170,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      stops: [0.3, 0.7],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffa1d4ed), Color(0xffc0eaff)]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Let's start the diagnosis, upload the x-ray",
                      style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 23, 51, 84),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
            if (image != null)
              SizedBox(
                width: double.infinity,
                child: Image(image: FileImage(image!)),
              )
          ],
        ),
      ),
    );
  }
}
