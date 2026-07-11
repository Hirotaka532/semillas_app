import 'package:flutter/material.dart';
import '../../core/models/parcela_model.dart'; 

class ConucoInteractivo extends StatefulWidget {
  const ConucoInteractivo({super.key});

  @override
  State<ConucoInteractivo> createState() => _ConucoInteractivoState();
}

class _ConucoInteractivoState extends State<ConucoInteractivo> {
  List<ParcelaModel> _parcelas = [];

  @override
  void initState() {
    super.initState();
    _inicializarParcelas();
  }

  void _inicializarParcelas() {
    _parcelas = [
      ParcelaModel(id: 1, position: const Offset(120, 380)),
      ParcelaModel(id: 2, position: const Offset(280, 360)),
      ParcelaModel(id: 3, position: const Offset(440, 340)),
      ParcelaModel(id: 4, position: const Offset(150, 480)),
      ParcelaModel(id: 5, position: const Offset(320, 450)),
      ParcelaModel(id: 6, position: const Offset(490, 420)),
    ];
  }

  void _mostrarMenuSiembra(ParcelaModel parcela) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF00695C).withOpacity(0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¿Qué semilla vas a sembrar?',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _botonCultivo(context, parcela, 'Yuca', 'yuca'),
                  _botonCultivo(context, parcela, 'Maíz', 'maiz'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _botonCultivo(BuildContext context, ParcelaModel parcela, String nombre, String idCultivo) {
    return GestureDetector(
      onTap: () {
        setState(() {
          parcela.etapa = 1;
          parcela.cultivo = idCultivo;
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('🌱 ¡$nombre sembrado!')),
        );
      },
      child: Column(
        children: [
          const Icon(Icons.eco, color: Colors.lightGreenAccent, size: 50),
          const SizedBox(height: 8),
          Text(nombre, style: const TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }

  void _interactuar(ParcelaModel parcela) {
    if (parcela.etapa < 3) {
      setState(() => parcela.etapa++);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('💧 ¡La planta ha crecido!')),
      );
    } else if (parcela.etapa == 3) {
      setState(() {
        parcela.etapa = 0;
        parcela.cultivo = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🧺 ¡Cosecha recolectada!')),
      );
    }
  }

  Widget _obtenerSprite(ParcelaModel parcela) {
    if (parcela.etapa == 0) {
      return Image.asset('assets/images/sprites/parcela_vacia.png', width: 80, height: 80);
    }
    
    // Nomenclatura dinámica: ej. "assets/images/sprites/yuca_1.png"
    String rutaSprite = 'assets/images/sprites/${parcela.cultivo}_${parcela.etapa}.png';
    
    return Image.asset(
      rutaSprite,
      width: 100, 
      height: 100,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.bug_report, color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _parcelas.map((parcela) {
        return Positioned(
          left: parcela.position.dx,
          top: parcela.position.dy,
          child: GestureDetector(
            onTap: () {
              if (parcela.etapa == 0) {
                _mostrarMenuSiembra(parcela);
              } else {
                _interactuar(parcela);
              }
            },
            child: _obtenerSprite(parcela),
          ),
        );
      }).toList(),
    );
  }
}