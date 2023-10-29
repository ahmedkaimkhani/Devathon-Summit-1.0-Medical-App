import 'package:devathon_smit_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final TextStyle? buttonTextStyle;
  final Color? buttonColor;
  final IconData? buttonIcon;
  final Color? borderColor;
  final Function()? onPressed;
  final Padding? height;
  final bool loading;
  const CustomButton(
      {super.key,
      required this.buttonText,
      this.buttonColor,
      this.buttonIcon,
      this.buttonTextStyle,
      this.onPressed,
      this.height,
      this.borderColor,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: buttonColor ?? AppColors.litePurple,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor ?? Colors.transparent)),
      ),
      child: buttonIcon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Icon(
                    buttonIcon,
                    color: AppColors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  buttonText,
                  style: buttonTextStyle ??
                      const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            )
          : Padding(
              padding: loading == true
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.all(20),
              child: loading
                  ? Visibility(
                      visible: loading,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: Colors.white,
                      ))
                  : Text(
                      buttonText,
                      style: buttonTextStyle ?? TextStyle(fontSize: 14),
                    ),
            ),
    );
  }
}
