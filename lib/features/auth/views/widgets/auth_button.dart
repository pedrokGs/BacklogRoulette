import 'package:backlog_roulette/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Size size;
  final Color color;
  final double borderRadius;
  const AuthButton({
    super.key,
    required this.child,
    required this.onTap,
    this.size = const Size(100, 48),
    this.color = AppColors.primaryPurple,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: size.width,
      height: size.height,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          splashColor: Colors.black.withValues(alpha: 0.2),
          highlightColor: Colors.black.withValues(alpha: 0.4),
          onTap: onTap,

          child: Center(child: child),
        ),
      ),
    );
  }
}
