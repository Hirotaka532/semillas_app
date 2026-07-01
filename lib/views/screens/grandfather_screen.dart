import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../layouts/base_layout.dart';


class Historia {
  final int id;
  final String titulo;
  final String contenido;

  Historia({required this.id, required this.titulo, required this.contenido});

  factory Historia.fromJson(Map<String, dynamic> json) {
    return Historia(
      id: json['id'] as int,
      titulo: json['titulo'] as String,
      contenido: json['contenido'] as String,
    );
  }
}

class GrandfatherScreen extends StatefulWidget {
  const GrandfatherScreen({super.key});

  @override
  State<GrandfatherScreen> createState() => _GrandfatherScreenState();
}

class _GrandfatherScreenState extends State<GrandfatherScreen> {
  List<Historia> _historias = [];
  Historia? _historiaSeleccionada;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarCuentos();
  }

  // Tarea 3: Lógica para leer el JSON local
  Future<void> _cargarCuentos() async {
    try {
      final String response = await rootBundle.loadString('assets/data/cuentos_nivel1.json');
      final data = json.decode(response);
      final List<dynamic> listaJson = data['historias'];

      setState(() {
        _historias = listaJson.map((item) => Historia.fromJson(item)).toList();
        if (_historias.isNotEmpty) {
          _historiaSeleccionada = _historias.first; // Inicializa con la primera historia
        }
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error cargando el JSON de cuentos: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      backgroundPath: 'assets/images/Abuelo_bg.webp', // Ruta del fondo solicitada
      child: Stack(
        children: [
          // Botón para regresar al Conuco (Usa el mismo diseño circular de la app)
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFD84315),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),

          // Contenido Principal de la UI del Abuelo
          Positioned.fill(
            child: SafeArea(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFD84315)))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        children: [
                          // Tarea 2: Menú lateral de 5 botones (Temas)
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(bottom: 80), // Espacio para el botón regresar
                            child: ListView.builder(
                              itemCount: _historias.length,
                              itemBuilder: (context, index) {
                                final historia = _historias[index];
                                final isSelected = _historiaSeleccionada?.id == historia.id;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Tarea 3: Actualizar texto en pantalla usando setState
                                      setState(() {
                                        _historiaSeleccionada = historia;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isSelected ? const Color(0xFFD84315) : Colors.white.withValues(alpha: 0.85),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: isSelected ? Colors.white : const Color(0xFFD84315).withValues(alpha: 0.5),
                                          width: 2,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
                                        ],
                                      ),
                                      child: Text(
                                        historia.titulo,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 20),

                          // Pantalla Narrativa que renderiza la historia seleccionada
                          Expanded(
                            child: _historiaSeleccionada == null
                                ? const Center(child: Text("Selecciona un tema ancestral"))
                                : Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: const Color(0xFFFFC107), width: 3), // Borde dorado estilo panel
                                      boxShadow: const [
                                        BoxShadow(color: Colors.black38, blurRadius: 10, offset: Offset(0, 4)),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _historiaSeleccionada!.titulo,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFFD84315),
                                          ),
                                        ),
                                        const Divider(height: 20, thickness: 2, color: Color(0xFFFFC107)),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            physics: const BouncingScrollPhysics(),
                                            child: Text(
                                              _historiaSeleccionada!.contenido,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                height: 1.6,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}