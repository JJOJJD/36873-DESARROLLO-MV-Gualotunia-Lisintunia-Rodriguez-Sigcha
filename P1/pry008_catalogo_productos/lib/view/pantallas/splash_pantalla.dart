import 'package:flutter/material.dart';

class SplashPantalla extends StatefulWidget {
  const SplashPantalla({super.key});

  @override
  State<SplashPantalla> createState() => _SplashPantallaState();
}

class _SplashPantallaState extends State<SplashPantalla>
    with SingleTickerProviderStateMixin {
  late AnimationController _controlador;
  late Animation<double> _animacionOpacidad;
  late Animation<double> _animacionEscala;

  @override
  void initState() {
    super.initState();
    _controlador = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animacionOpacidad = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controlador, curve: Curves.easeIn),
    );

    _animacionEscala = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controlador, curve: Curves.easeOutBack),
    );

    _controlador.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/productos');
      }
    });
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Center(
        child: AnimatedBuilder(
          animation: _controlador,
          builder: (context, child) {
            return Opacity(
              opacity: _animacionOpacidad.value,
              child: Transform.scale(
                scale: _animacionEscala.value,
                child: child,
              ),
            );
          },
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 90,
                color: Colors.white,
              ),
              SizedBox(height: 16),
              Text(
                'TecnoTienda',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Catálogo de Productos',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
