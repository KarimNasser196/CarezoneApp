import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';


import '../resourses/Color_manager.dart';
import '../resourses/routes_manager.dart';
import '../resourses/styles_manager.dart';
import '../resourses/values_manager.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({super.key});

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.grey,
            title: Text(
              'Hello Friend !',
              style: getRegularStyle(
                  color: ColorManager.white, fontSize: AppSize.s18),
            ),
            automaticallyImplyLeading: false,
          ),
          const SizedBox(
            height: AppSize.s4,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: AppSize.s32,
            ),
            title: Text('Home',
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.mainRoute),
          ),
          Divider(
            color: ColorManager.black,
            thickness: 0.8,
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_outlined,
              size: AppSize.s32,
            ),
            title: Text('Sign Out',
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(Routes.login);
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
