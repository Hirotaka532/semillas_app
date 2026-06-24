import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:go_router/go_router.dart';
import 'package:semillas_app/core/router/router.dart';
import 'package:semillas_app/core/database/database_helper.dart';
import '../layouts/base_layout.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;
  Map<String, dynamic>? _lider;
  bool _hasCheckedLider = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
    _checkLider();
  }

  Future<void> _checkLider() async {
    try {
      final lider = await DatabaseHelper.instance.verificarLiderExistente();
      if (mounted) {
        setState(() {
          _lider = lider;
          _hasCheckedLider = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasCheckedLider = true;
        });
      }
    }
  }

  // Control de audio
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      _audioPlayer.resume();
    }
  }

  void _playBackgroundMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('audio/GameMusic.ogg'));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    super.dispose();
  }

  void _startGame() {
    _audioPlayer.stop();
    context.go('/creation');
    if (_lider == null) {
      _showRegisterDialog();
    } else {
      _audioPlayer.stop();
      context.go(AppRoutes.village); // Navega a la pantalla del pueblo
    }
  }

  void _showRegisterDialog() {
    final nameController = TextEditingController();
    final villageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false, // Obliga al usuario a registrarse o cancelar
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          backgroundColor: const Color.fromARGB(255, 0, 105, 39), // Verde Selva
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFC107), width: 4), // Borde Dorado
            ),
            width: 400,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'REGISTRAR LÍDER',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFFC107),
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Ingresa tus datos para comenzar tu aventura en el Amazonas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo de Nombre
                    TextFormField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: 'Nombre del Líder',
                        labelStyle: const TextStyle(color: Color(0xFFFFC107)),
                        hintText: 'Ej. Inés',
                        hintStyle: const TextStyle(color: Colors.white38),
                        prefixIcon: const Icon(Icons.person, color: Color(0xFFFFC107)),
                        filled: true,
                        fillColor: Colors.black26,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xFFFFC107), width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor ingresa un nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Campo de Aldea
                    TextFormField(
                      controller: villageController,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: 'Nombre de la Aldea',
                        labelStyle: const TextStyle(color: Color(0xFFFFC107)),
                        hintText: 'Ej. Semillas',
                        hintStyle: const TextStyle(color: Colors.white38),
                        prefixIcon: const Icon(Icons.home, color: Color(0xFFFFC107)),
                        filled: true,
                        fillColor: Colors.black26,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xFFFFC107), width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor ingresa una aldea';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF8F00), // Naranja vibrante
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Colors.white, width: 2),
                            ),
                            elevation: 5,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final name = nameController.text.trim();
                              final village = villageController.text.trim();
                              
                              await DatabaseHelper.instance.crearNuevoLider(name, village);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                _audioPlayer.stop();
                                context.go(AppRoutes.village);
                              }
                            }
                          },
                          child: const Text(
                            'Comenzar',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      backgroundPath: 'assets/images/Home_bg.webp',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 105, 39),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFC107), width: 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text(
                    'SEMILLAS DE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFC107),
                      letterSpacing: 6.0,
                    ),
                  ),
                  Text(
                    'IDENTIDAD',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 4.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 170, 0),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                !_hasCheckedLider
                    ? 'Cargando aventura...'
                    : _lider != null
                        ? '¡Bienvenido, Líder ${_lider!['nombre']}!'
                        : '¡Bienvenido a la cosecha!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF00695B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFC107), width: 5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45, 
            blurRadius: 15, 
            offset: Offset(0, 10)
          )
        ],
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SEMILLAS DE', 
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.w900, 
              color: Color(0xFFFFC107), 
              letterSpacing: 4
            )
          ),
          Text(
            'IDENTIDAD', 
            style: TextStyle(
              fontSize: 45, 
              fontWeight: FontWeight.w900, 
              color: Colors.white, 
              letterSpacing: 2
            )
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFAA00),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Text(
        '¡Bienvenido a la cosecha!', 
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold, 
          color: Colors.white
        )
      ),
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: _startGame,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFCA28), Color(0xFFFF8F00)], 
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter
          ),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFB15300), 
              offset: Offset(0, 6)
            )
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_arrow_rounded, color: Colors.white, size: 35),
            SizedBox(width: 10),
            Text(
              'EMPEZAR', 
              style: TextStyle(
                fontSize: 26, 
                fontWeight: FontWeight.w900, 
                color: Colors.white
              )
            ),
          ],
        ),
      ),
    );
  }
}