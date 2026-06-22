import 'package:flutter/material.dart';
import '../layouts/base_layout.dart';

class EbookScreen extends StatelessWidget {
  const EbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      backgroundPath: 'assets/images/Conuco_bg.webp', 
      child: Center(
        child: Text('Equipo: Aca va la UI del ebook sobre la flora y fauna'),
      ),
    );
  }
}