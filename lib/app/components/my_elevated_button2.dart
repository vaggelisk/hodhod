
import 'package:flutter/material.dart';
import 'package:hodhod/app/config/app_colors.dart';

class MyElevatedButton2 extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final EdgeInsetsDirectional? padding;

  const MyElevatedButton2({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.color,
    this.height = 48.0,
    this.gradient,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsetsDirectional.zero,
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.16), //shadow for button
                blurRadius: 19) //blur radius of shadow
          ]),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
