import 'package:flutter/material.dart';
import 'package:garden_app/config/config.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = AppColors.mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(6.0),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: AppColors.mainColor.dark,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: AppStyles.whiteMedium(14),
            ),
          ),
        ),
      ),
    );
  }
}
