import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final IconData? icon;
  final IconData? iconR;
  final Function()? onPressed;
  final bool isPasswordVisible;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    Key? key,
    required this.title,
    this.icon,
    this.controller,
    required this.validator,
    this.iconR,
    this.isPasswordVisible = false,
    this.onPressed,
  }) : super(key: key);

  bool isVisible(obscureText) {
    return obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordVisible,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: title,
        hintStyle: const TextStyle(
            fontSize: 12,
            color: Color(0xff747474),
            fontWeight: FontWeight.w300),
        // focusedBorder: InputBorder.,
        suffixIcon: GestureDetector(onTap: onPressed, child: Icon(iconR)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      validator: validator,
    );
  }
}
