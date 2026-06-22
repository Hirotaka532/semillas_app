import 'package:flutter/material.dart';
import '../layouts/base_layout.dart';

class GrandfatherScreen extends StatelessWidget {
  const GrandfatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      backgroundPath: 'assets/images/Abuelo_bg.webp', 
      child: Center(
        child: Text('Equipo: Aca va la UI del abuelo'),
      ),
    );
  }
}