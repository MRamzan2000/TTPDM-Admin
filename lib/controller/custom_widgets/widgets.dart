import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_colors.dart';
import 'custom_text_styles.dart';

Widget getVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget getHorizentalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget svgImage(String path, {Color? color}) {
  return SvgPicture.asset(
    path,
    fit: BoxFit.cover,
    color: color,
  );
}

Widget pngImage(String name) {
  return Image.asset(name);
}

Widget customElevatedButton(
    {Callback? onTap,
    required Widget title,
    Color? bgColor,
    double? horizentalPadding,
    double? verticalPadding,
    Color? titleColor}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(bgColor)),
    child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizentalPadding ?? 6.h,
            vertical: verticalPadding ?? 1.h),
        child: title),
  );
}

//CustomTextFormField
Widget customTextFormField({
  String? title,
  TextEditingController? controller,
  TextInputType? keyboardType,
  int? maxLines = 1, // Set default to 1 for single-line input
  String? errorText,
  Color? focusBorderColor,
  Color? bgColor,
  Color? borderColor,
  BorderRadius? borderRadius,
  BorderRadius? borderRadius1,
}) {
  return TextFormField(
    maxLines: maxLines,
    cursorColor: AppColors.mainColor,
    keyboardType: keyboardType,
    controller: controller,
    decoration: InputDecoration(
      hintText: title,
      hintStyle: CustomTextStyles.hintTextStyle,
      isCollapsed: true,
      labelText: errorText,
      labelStyle: TextStyle(
        fontSize: 15.sp,
        color: const Color(0xff808080),
        fontWeight: FontWeight.w400,
        fontFamily: 'regular',
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusBorderColor ?? AppColors.mainColor),
        borderRadius: borderRadius1 ?? BorderRadius.circular(1.h),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.transparent),
        borderRadius: borderRadius ?? BorderRadius.circular(1.h),
      ),
      border: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(1.h),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      filled: true,
      fillColor: bgColor ?? AppColors.textFieldGreyColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 1.6.h, vertical: 1.h),
    ),
  );
}
