import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:carezone/models/advice.dart';
import 'package:carezone/ui/resourses/values_manager.dart';

import '../resourses/Color_manager.dart';

// ignore: must_be_immutable
class MoreAdviceScreenDetails extends StatelessWidget {
  int x;

  MoreAdviceScreenDetails({
    Key? key,
    required this.x,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
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
                    ? moreadvice[0]['Image'].toString()
                    : x == 1
                        ? moreadvice[1]['Image'].toString()
                        : x == 2
                            ? moreadvice[2]['Image'].toString()
                            : x == 3
                                ? moreadvice[3]['Image'].toString()
                                : moreadvice[4]['Image'].toString(),
                fit: BoxFit.cover,
              )),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Text(
                  x == 0
                      ? moreadvice[0]['Title'].toString()
                      : x == 1
                          ? moreadvice[1]['Title'].toString()
                          : x == 2
                              ? moreadvice[2]['Title'].toString()
                              : x == 3
                                  ? moreadvice[3]['Title'].toString()
                                  : moreadvice[4]['Title'].toString(),
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
                        ? moreadvice[0]['description'].toString()
                        : x == 1
                            ? moreadvice[1]['description'].toString()
                            : x == 2
                                ? moreadvice[2]['description'].toString()
                                : x == 3
                                    ? moreadvice[3]['description'].toString()
                                    : moreadvice[4]['description'].toString(),
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
