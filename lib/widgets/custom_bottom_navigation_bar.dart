import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<Color?>> _colorAnimations;

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(5, (index) => AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    ));
    _scaleAnimations = _animationControllers.map((controller) => Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut),
    )).toList();
    _colorAnimations = _animationControllers.map((controller) => ColorTween(
      begin: Colors.black.withOpacity(0.6),
      end: const Color(0xFF00FFFF),
    ).animate(controller)).toList();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.grey.shade300,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(
          color: const Color(0xFF00FFFF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FFFF).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: -2,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.dashboard, 'Dashboard'),
          _buildNavItem(1, Icons.people, 'Empleados'),
          _buildNavItem(2, Icons.build, 'Habilidades'),
          _buildNavItem(3, Icons.task, 'Tareas'),
          _buildNavItem(4, Icons.assignment, 'Asignaciones'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () {
        widget.onTap(index);
        _animationControllers[index].forward().then((_) => _animationControllers[index].reverse());
      },
      child: AnimatedBuilder(
        animation: _animationControllers[index],
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? _scaleAnimations[index].value : 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? _colorAnimations[index].value : Colors.black.withOpacity(0.6),
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? _colorAnimations[index].value : Colors.black.withOpacity(0.6),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(0, height * 0.3);
    path.quadraticBezierTo(width * 0.25, 0, width * 0.5, height * 0.3);
    path.quadraticBezierTo(width * 0.75, height * 0.6, width, height * 0.3);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
