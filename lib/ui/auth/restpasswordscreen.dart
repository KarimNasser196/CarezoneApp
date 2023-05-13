import 'package:carezone/ui/resourses/values_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resourses/Color_manager.dart';

class RestPasswordScreen extends StatefulWidget {
  const RestPasswordScreen({super.key});

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  final TextEditingController _email = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Future<void> passwordRest() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());

      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  color: Colors.teal,
                  child: const Text('Ok'),
                )
              ],
              content:
                  const Text('password reset link sent! check your email '),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  color: Colors.teal,
                  child: const Text('Ok'),
                )
              ],
            );
          });
    }
  }

  void _submit() async {
    final isvaild = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isvaild) {
      _formkey.currentState!.save();
      passwordRest();
    }
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
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
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/14562381_5500661.jpg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Please Enter your Email And We Will Send You A password Reset Link',
                  style: GoogleFonts.roboto(
                      fontSize: AppSize.s20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'please enter a valid address';
                      }
                      return null;
                    },
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[350],
                      hintText: 'Email',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _submit,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal)),
                child: const Text('Password Rest'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
