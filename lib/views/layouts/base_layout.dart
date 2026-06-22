import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final String backgroundPath;
  final Widget child;

  const BaseLayout({
    super.key,
    required this.backgroundPath,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(backgroundPath, fit: BoxFit.cover),
          ),
          Positioned.fill(child: SafeArea(child: child)),
        ],
      ),
    );
  }
}
