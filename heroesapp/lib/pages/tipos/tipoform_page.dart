import 'package:buscador_de_peliculas/bll/tipo_bll.dart';
import 'package:buscador_de_peliculas/models/tipo.dart';
import 'package:flutter/material.dart';

class TipoFormPage extends StatefulWidget {
  const TipoFormPage({super.key, this.id});

  final int? id;

  @override
  State<TipoFormPage> createState() => _TipoFormPageState();
}

class _TipoFormPageState extends State<TipoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      // Cargar el tipo
      TipoBLL.selectById(widget.id!).then((tipo) {
        _nombreController.text = tipo.nombre;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'Nuevo Tipo' : 'Editar Tipo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var tipo = Tipo(
                      id: widget.id,
                      nombre: _nombreController.text,
                    );
                    if (widget.id == null) {
                      await TipoBLL.insert(tipo);
                    } else {
                      await TipoBLL.update(tipo);
                    }
                    // Redirige a la lista de tipos
                    Navigator.pushReplacementNamed(context, '/tipo/list');
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
