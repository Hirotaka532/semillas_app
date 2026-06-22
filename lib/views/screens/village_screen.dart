import 'package:flutter/material.dart';
import '../layouts/base_layout.dart';
import 'curiara_travel_screen.dart';
import 'grandfather_screen.dart';
import 'ebook_screen.dart';

class VillageScreen extends StatelessWidget {
  const VillageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      backgroundPath: 'assets/images/Conuco_bg.webp',
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'Equipo: Aquí va la cuadrícula de siembra',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF00695C),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFFFC107), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF00695C),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Líder: Inés',
                        style: TextStyle(
                          color: Color(0xFFFFC107),
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Aldea: Semillas',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            bottom: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavButton(
                  context,
                  icon: Icons.rowing,
                  color: const Color(0xFF0288D1),
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CuriaraTravelScreen(),
                        ),
                      ),
                ),
                _buildNavButton(
                  context,
                  icon: Icons.person_2_sharp,
                  color: const Color(0xFFD84315),
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GrandfatherScreen(),
                        ),
                      ),
                ),
                _buildNavButton(
                  context,
                  icon: Icons.menu_book,
                  color: const Color(0xFF388E3C),
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EbookScreen(),
                        ),
                      ),
                ),
                _buildNavButton(
                  context,
                  icon: Icons.workspace_premium,
                  color: const Color(0xFFFF8F00),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            const BoxShadow(color: Colors.black54, offset: Offset(0, 5)),
            BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 36),
      ),
    );
  }
}
