import 'package:flutter/material.dart';
import '../../controlador/agua_controlador.dart';
import '../../modelo/consumo_modelo.dart';
import '../../tema/tema_app.dart';
import '../moleculas/campo_formulario.dart';
import '../moleculas/selector_tipo_consumidor.dart';
import '../moleculas/botonera_acciones.dart';

/// Organismo 2: Formulario de captura y calculo de consumo de agua potable
class FormularioConsumo extends StatefulWidget {
  final AguaControlador controlador;
  final void Function(ConsumoAguaModelo modelo) alCalcularExitoso;

  const FormularioConsumo({
    super.key,
    required this.controlador,
    required this.alCalcularExitoso,
  });

  @override
  State<FormularioConsumo> createState() => _FormularioConsumoState();
}

class _FormularioConsumoState extends State<FormularioConsumo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cuentaCtrl = TextEditingController();
  final TextEditingController _clienteCtrl = TextEditingController();
  final TextEditingController _anteriorCtrl = TextEditingController();
  final TextEditingController _actualCtrl = TextEditingController();
  String _tipoConsumidor = 'Residencial';
  String? _errorMensaje;

  @override
  void dispose() {
    _cuentaCtrl.dispose();
    _clienteCtrl.dispose();
    _anteriorCtrl.dispose();
    _actualCtrl.dispose();
    super.dispose();
  }

  void _limpiar() {
    _cuentaCtrl.clear();
    _clienteCtrl.clear();
    _anteriorCtrl.clear();
    _actualCtrl.clear();
    _formKey.currentState?.reset();
    setState(() {
      _tipoConsumidor = 'Residencial';
      _errorMensaje = null;
    });
  }

  void _calcular() {
    setState(() {
      _errorMensaje = null;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final double? anterior = double.tryParse(_anteriorCtrl.text.trim());
    final double? actual = double.tryParse(_actualCtrl.text.trim());

    if (anterior == null || actual == null) {
      setState(() {
        _errorMensaje = 'Las lecturas deben ser valores numéricos válidos.';
      });
      return;
    }

    final String? errorLecturas = widget.controlador.validarLecturas(anterior, actual);
    if (errorLecturas != null) {
      setState(() {
        _errorMensaje = errorLecturas;
      });
      return;
    }

    final ConsumoAguaModelo resultado = widget.controlador.liquidarConsumo(
      numeroCuenta: _cuentaCtrl.text.trim(),
      nombreCliente: _clienteCtrl.text.trim(),
      lecturaAnterior: anterior,
      lecturaActual: actual,
      tipoConsumidor: _tipoConsumidor,
    );

    widget.alCalcularExitoso(resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CampoFormulario(
                etiqueta: 'Número de Cuenta / Contrato',
                controller: _cuentaCtrl,
                pista: 'Ej. 09812345',
                icono: Icons.tag,
                tipoTeclado: TextInputType.number,
                validador: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Ingrese el número de cuenta.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              CampoFormulario(
                etiqueta: 'Nombre del Cliente',
                controller: _clienteCtrl,
                pista: 'Ej. Carlos Andrade',
                icono: Icons.badge_outlined,
                tipoTeclado: TextInputType.name,
                validador: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Ingrese el nombre del cliente.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CampoFormulario(
                      etiqueta: 'Lectura Anterior (m³)',
                      controller: _anteriorCtrl,
                      pista: '0.00',
                      icono: Icons.history,
                      tipoTeclado: const TextInputType.numberWithOptions(decimal: true),
                      validador: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Requerido';
                        }
                        if (double.tryParse(v.trim()) == null) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CampoFormulario(
                      etiqueta: 'Lectura Actual (m³)',
                      controller: _actualCtrl,
                      pista: '0.00',
                      icono: Icons.speed,
                      tipoTeclado: const TextInputType.numberWithOptions(decimal: true),
                      validador: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Requerido';
                        }
                        if (double.tryParse(v.trim()) == null) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SelectorTipoConsumidor(
                valorSeleccionado: _tipoConsumidor,
                alCambiar: (nuevoTipo) {
                  setState(() {
                    _tipoConsumidor = nuevoTipo;
                  });
                },
              ),
              if (_errorMensaje != null) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: TemaApp.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: TemaApp.error.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: TemaApp.error, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMensaje!,
                          style: const TextStyle(
                            color: TemaApp.error,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 22),
              BotoneraAcciones(
                textoPrincipal: 'Calcular Planilla',
                alPresionarPrincipal: _calcular,
                iconoPrincipal: Icons.calculate_outlined,
                textoSecundario: 'Limpiar',
                alPresionarSecundario: _limpiar,
                iconoSecundario: Icons.refresh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
