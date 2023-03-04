// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:carezone/models/advice.dart';
import 'package:carezone/ui/advicescreen/moreadvicescreendetails.dart';
import 'package:carezone/ui/pages/screens/add_task_page.dart';

// ignore: must_be_immutable
class MoreAdvice extends StatelessWidget {
  const MoreAdvice({super.key});


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(),
        body: GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: moreadvice.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 5 / 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemBuilder: ((context, ind) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black26,
                        title: Text(
                          moreadvice[ind]['Title'].toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      child: GestureDetector(
                          child: Image.asset(
                            moreadvice[ind]['Image'].toString(),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    MoreAdviceScreenDetails(x: ind))));
                          })),
                ))));
  }
}
