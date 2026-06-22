import 'package:flutter/material.dart';
import '../layouts/base_layout.dart';

class CuriaraTravelScreen extends StatelessWidget {
  const CuriaraTravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      backgroundPath: 'assets/images/Curiaras_bg.webp', 
      child: Center(
        child: Text('Equipo: Aca va la UI del viaje en curiara y sincronizacion'),
      ),
    );
  }
}