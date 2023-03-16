
import 'dart:async';

import 'package:carezone/ui/disease_diagnosis_screen/disease_diagnosis_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';


class Ai extends StatefulWidget
{
  @override
  State<Ai> createState()=>Aistate();


}
class Aistate extends State<Ai> {
  var _time;
  start()
  {
    _time=Timer(const Duration(seconds: 2), call);
  }
  void call()
  {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=>const DiseaseDiagosis(),),
    );
  }
  @override
  void initState()
  {
    start();
    super.initState();
  }
  @override
  void dispose()
  {
    _time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff55598d),

      body: Center(child:Lottie.asset('images/121988-ai-animation.json')),
    );
  }
}