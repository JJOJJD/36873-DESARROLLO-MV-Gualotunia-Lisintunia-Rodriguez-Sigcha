import 'package:flutter/material.dart';
import '../../tema/tema_app.dart';
import '../moleculas/encabezado_pantalla.dart';
import '../organismos/formulario_login.dart';

/// Pantalla 1: Inicio de Sesion y autenticacion local
class LoginPantalla extends StatelessWidget {
  const LoginPantalla({super.key});

  void _autenticar(BuildContext context, String usuario, String contrasena) {
    const String usuarioValido = 'admin@agua.gob.ec';
    const String claveValida = 'agua123';

    if (usuario == usuarioValido && contrasena == claveValida) {
      // Navegacion hacia la pantalla principal mediante rutas con nombre
      Navigator.pushReplacementNamed(context, '/consumo');
    } else {
      // Mensaje defensivo de alerta cuando los datos son incorrectos
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: const Row(
            children: [
              Icon(Icons.error_outline, color: TemaApp.error),
              SizedBox(width: 8),
              Text(
                'Acceso Denegado',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'El usuario o la contraseña ingresados no son correctos.\n\nPor favor revise las credenciales de prueba indicadas en el formulario.',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Entendido'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicio de Agua Potable'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EncabezadoPantalla(
                    icono: Icons.water_drop,
                    titulo: 'Portal de Abonados',
                    subtitulo: 'Sistema de cálculo y liquidación de agua potable',
                  ),
                  const SizedBox(height: 24),
                  FormularioLogin(
                    alIniciarSesion: (user, pass) => _autenticar(context, user, pass),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
