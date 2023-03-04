import 'package:flutter/material.dart';

import '../../resourses/Color_manager.dart';
import '../../resourses/styles_manager.dart';
import '../../resourses/values_manager.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: getBoldStyle(
                  color: ColorManager.black, fontSize: AppSize.s18)),
          Container(
            padding: const EdgeInsets.only(left: 14),
            margin: const EdgeInsets.only(top: 8),
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12),
              // border: Border.all(
              //   color: ColorManager.grey,
              // ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    readOnly: widget != null ? true : false,
                    style: getMediumStyle(
                        color: ColorManager.black, fontSize: AppSize.s18),
                    cursorColor: Colors.grey[100],
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: getRegularStyle(
                          color: ColorManager.black, fontSize: AppSize.s18),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
