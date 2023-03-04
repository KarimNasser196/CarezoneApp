// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carezone/ui/resourses/values_manager.dart';
import 'package:flutter/material.dart';

import 'package:carezone/models/advice.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resourses/Color_manager.dart';

// ignore: must_be_immutable
class AdviceScreen extends StatelessWidget {
  int x;


  AdviceScreen(this.x, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 26,
                  color: ColorManager.black,
                ),
              ),
              backgroundColor: Colors.white,
              expandedHeight: 280,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                x == 0
                    ? advice[0]['Image'].toString()
                    : x == 1
                        ? advice[1]['Image'].toString()
                        : advice[2]['Image'].toString(),
                fit: BoxFit.cover,
              )),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Text(
                  x == 0
                      ? advice[0]['Title'].toString()
                      : x == 1
                          ? advice[1]['Title'].toString()
                          : advice[2]['Title'].toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: AppSize.s25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                    x == 0
                        ? advice[0]['description'].toString()
                        : x == 1
                            ? advice[1]['description'].toString()
                            : advice[2]['description'].toString(),
                    textAlign: TextAlign.start,
                    softWrap: true,
                    style: GoogleFonts.roboto(
                        fontSize: AppSize.s18, color: Colors.grey[800])),
              ),
              const SizedBox(
                height: 180,
              ),
            ]))
          ],
        ));
  }
}
