import 'package:flutter/material.dart';
import '../layouts/base_layout.dart';

class EbookItem {
  final String name;
  final String imagePath;
  final String type; 
  final bool descubierto;

  const EbookItem({
    required this.name,
    required this.imagePath,
    required this.type,
    required this.descubierto,
  });
}

class EbookScreen extends StatefulWidget {
  const EbookScreen({super.key});

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3; 

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _anteriorPagina() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _siguientePagina() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<EbookItem> todasLasPlantas = [
      const EbookItem(name: 'Moriche Palm', imagePath: 'assets/images/moriche.png', type: 'planta', descubierto: true),
      const EbookItem(name: 'Victoria Amazónica', imagePath: 'assets/images/victoria_amazonica.png', type: 'planta', descubierto: true),
    ];

    final List<EbookItem> todosLosAnimales = [
      const EbookItem(name: 'Guacamaya', imagePath: 'assets/images/guacamaya.png', type: 'animal', descubierto: true),
      const EbookItem(name: 'Danta', imagePath: 'assets/images/danta.png', type: 'animal', descubierto: false),
    ];

    final List<EbookItem> todasLasAguas = [
      const EbookItem(name: 'Agua Dulce', imagePath: 'assets/images/Home_bg.webp', type: 'agua', descubierto: true),
    ];

    return BaseLayout(
      backgroundPath: 'assets/images/Conuco_bg.webp',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                height: 440,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE6D4), 
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                  border: Border.all(color: const Color(0xFF4E342E), width: 6),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 2,
                        color: const Color(0xFF8D6E63).withOpacity(0.4),
                      ),
                    ),
                    PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        Row(
                          children: [
                            Expanded(child: _buildHalfPage(titulo: "Nuestra Flora", items: todasLasPlantas)),
                            const SizedBox(width: 16), 
                            Expanded(child: Container()), 
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: _buildHalfPage(titulo: "Nuestra Fauna", items: todosLosAnimales)),
                            const SizedBox(width: 16),
                            Expanded(child: Container()), 
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: _buildHalfPage(titulo: "Nuestra Agua", items: todasLasAguas)),
                            const SizedBox(width: 16),
                            Expanded(child: Container()), 
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (_currentPage > 0)
                Positioned(
                  left: 4,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF388E3C),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFEFE6D4), size: 18),
                      onPressed: _anteriorPagina,
                    ),
                  ),
                ),
              if (_currentPage < _totalPages - 1)
                Positioned(
                  right: 4,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF388E3C),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFFEFE6D4), size: 18),
                      onPressed: _siguientePagina,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHalfPage({required String titulo, required List<EbookItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          titulo,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2723),
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 1.0,
                color: Colors.black26,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 0.85,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  if (item.descubierto) {
                    _mostrarPopupInformativo(context, item);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: item.descubierto
                          ? Image.asset(
                              item.imagePath,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 40, color: Colors.grey),
                            )
                          : ColorFiltered(
                              colorFilter: const ColorFilter.matrix([
                                0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0,
                                0, 0, 0, 1, 0,
                              ]),
                              child: Image.asset(
                                item.imagePath,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.help_center, size: 40, color: Colors.black54),
                              ),
                            ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.descubierto ? item.name : '???',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: item.descubierto ? Colors.brown.shade900 : Colors.black45,
                      ),
                    ),
                    if (item.descubierto)
                      const Icon(Icons.check_circle, color: Colors.green, size: 14),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _mostrarPopupInformativo(BuildContext context, EbookItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF4ECD8), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF4E342E), width: 3),
          ),
          title: Text(
            item.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF3E2723),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Container(
                height: 120,
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Has descubierto con éxito este elemento en tu bitácora de la naturaleza. Pertenece a la categoría de ${item.type == 'animal' ? 'la Fauna' : (item.type == 'planta' ? 'la Flora' : 'los recursos hídricos')}.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF388E3C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Cerrar',
                  style: TextStyle(color: Color(0xFFEFE6D4), fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}