import 'dart:convert';
import 'dart:io';
import 'package:carezone/ui/resourses/Color_manager.dart';
import 'package:carezone/ui/resourses/styles_manager.dart';
import 'package:carezone/ui/resourses/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class DiseaseDiagosis extends StatefulWidget {
  const DiseaseDiagosis({super.key});
  @override
  State<DiseaseDiagosis> createState() => _DiseaseDiagosisState();
}

class _DiseaseDiagosisState extends State<DiseaseDiagosis> {
  String? result;
  final picker = ImagePicker();
  File? img;
  var url = 'https://hamada-production.up.railway.app/predictApi';
  Future pickImage() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) {
      return;
    } else {
      setState(() {
        img = File(pickedFile.path);
        result = null;
      });
    }
  }

  upload() async {
    setState(() {
      // Show the progress indicator
      result = 'waiting...';
    });
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final header = {'Content_type': 'multipart/form-data'};
    request.files.add(http.MultipartFile(
        'fileup', img!.readAsBytes().asStream(), img!.lengthSync(),
        filename: img!.path.split('/').last));
    request.headers.addAll(header);
    final myRequest = await request.send();
    http.Response res = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      final resJson = jsonDecode(res.body);
      print('response here: $resJson');
      result = resJson['prediction'];
    } else {
      print('Error ${myRequest.statusCode}');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Brain Tumor Detection',
            style: TextStyle(color: Colors.black87, fontSize: AppSize.s20)),
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
                margin: const EdgeInsets.symmetric(horizontal: AppSize.s4),
                width: MediaQuery.of(context).size.width,
                height: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Let's start the diagnosis, upload the x-ray",
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    OutlinedButton.icon(
                        icon: Icon(
                          Icons.image_outlined,
                          size: 35,
                          color: ColorManager.darkPrimary,
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const StadiumBorder()),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.teal)),
                        // color: Colors.blue,
                        label: const Text('Pick image',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.normal)),
                        onPressed: () async {
                          await pickImage();
                        }),
                    Visibility(
                      visible: img != null ? true : false,
                      child: OutlinedButton.icon(
                          icon: Icon(
                            Icons.upload_file,
                            size: 40,
                            color: Colors.red[300],
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const StadiumBorder()),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.teal)),
                          // color: Colors.blue,
                          label: const Text('upload to see result',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                          onPressed: () async {
                            await upload();
                          }),
                    ),
                  ],
                )),
            img == null
                ? Center(child: Lottie.asset('images/100943-perulogy.json'))
                : Image.file(img!),
            const SizedBox(
              height: AppSize.s20,
            ),
            result == null
                ? const Text('')
                : Container(
                    color: Colors.grey[200],
                    child: Text(
                      '$result',
                      style: getRegularStyle(
                          fontSize: AppSize.s32, color: Colors.black87),
                    )),
          ],
        ),
      ),
    );
  }
}
