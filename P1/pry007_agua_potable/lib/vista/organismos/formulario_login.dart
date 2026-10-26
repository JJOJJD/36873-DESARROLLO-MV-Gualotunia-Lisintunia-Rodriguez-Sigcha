import 'package:flutter/material.dart';
import '../../tema/tema_app.dart';
import '../atomos/etiqueta_texto.dart';
import '../moleculas/campo_formulario.dart';
import '../moleculas/botonera_acciones.dart';

/// Organismo 1: Formulario de inicio de sesion con validacion y accion de alternar contraseña
class FormularioLogin extends StatefulWidget {
  final void Function(String usuario, String contrasena) alIniciarSesion;

  const FormularioLogin({
    super.key,
    required this.alIniciarSesion,
  });

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioCtrl = TextEditingController();
  final TextEditingController _claveCtrl = TextEditingController();
  bool _ocultarClave = true;

  @override
  void dispose() {
    _usuarioCtrl.dispose();
    _claveCtrl.dispose();
    super.dispose();
  }

  void _limpiar() {
    _usuarioCtrl.clear();
    _claveCtrl.clear();
    _formKey.currentState?.reset();
    setState(() {});
  }

  void _enviar() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.alIniciarSesion(
        _usuarioCtrl.text.trim(),
        _claveCtrl.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CampoFormulario(
                etiqueta: 'Usuario o Correo Electrónico',
                controller: _usuarioCtrl,
                pista: 'ejemplo@agua.gob.ec',
                icono: Icons.person_outline,
                tipoTeclado: TextInputType.emailAddress,
                validador: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Ingrese su usuario o correo electrónico.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoFormulario(
                etiqueta: 'Contraseña de Acceso',
                controller: _claveCtrl,
                pista: 'Ingrese su clave secreta',
                icono: Icons.lock_outline,
                ocultarTexto: _ocultarClave,
                iconoFinal: IconButton(
                  icon: Icon(
                    _ocultarClave ? Icons.visibility_off : Icons.visibility,
                    color: TemaApp.textoSecundario,
                  ),
                  onPressed: () {
                    setState(() {
                      _ocultarClave = !_ocultarClave;
                    });
                  },
                ),
                validador: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Ingrese su contraseña de acceso.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 22),
              BotoneraAcciones(
                textoPrincipal: 'Iniciar Sesión',
                alPresionarPrincipal: _enviar,
                iconoPrincipal: Icons.login,
                textoSecundario: 'Limpiar',
                alPresionarSecundario: _limpiar,
                iconoSecundario: Icons.clear_all,
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: TemaApp.fondo,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFBAE6FD)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EtiquetaTexto(
                      texto: 'Credenciales de acceso local:',
                      peso: FontWeight.bold,
                      tamano: 12,
                      color: TemaApp.secundario,
                    ),
                    SizedBox(height: 4),
                    EtiquetaTexto(
                      texto: 'Usuario: admin@agua.gob.ec  |  Clave: agua123',
                      tamano: 12,
                      color: TemaApp.textoSecundario,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
