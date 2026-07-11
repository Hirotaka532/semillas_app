import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:go_router/go_router.dart';
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

  void _playBackgroundMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('audio/GameMusic.ogg'));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      _audioPlayer.resume();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      backgroundPath: 'assets/images/Home_bg.webp',

      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 25,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00695C),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xFFFFC107), width: 5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Text(
                      'SEMILLAS DE',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFFC107),
                        letterSpacing: 4.0,
                      ),
                    ),
                    Text(
                      'IDENTIDAD',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  !_hasCheckedLider
                      ? 'Cargando aventura...'
                      : (_lider != null
                          ? '¡Bienvenido de nuevo, Líder ${_lider!['nombre']}!'
                          : '¡Bienvenido a la cosecha!'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              if (!_hasCheckedLider)
                const CircularProgressIndicator(color: Colors.white)
              else
                ElevatedButton(
                  onPressed: () {
                    if (_lider != null) {
                      context.go('/village');
                    } else {
                      context.push('/creation');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _lider != null ? 'ENTRAR A LA ALDEA' : 'COMENZAR AVENTURA',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
