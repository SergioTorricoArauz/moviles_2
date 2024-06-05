import 'package:buscador_de_peliculas/bll/pelicula_bll.dart';
import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:flutter/material.dart';

class PeliculaForm extends StatefulWidget {
  const PeliculaForm({super.key});

  @override
  State<PeliculaForm> createState() => _FormValidadoPageState();
}

class _FormValidadoPageState extends State<PeliculaForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _imagenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Validado'),
      ),
      body: getForm(context),
    );
  }

  getForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nombreController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Nombre',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imagenController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Imagen',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una Imagen';
              }
              return null;
            },
          ),
          getButtonConDialog()
        ],
      ),
    );
  }

  getButtonConDialog() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Pelicula nuevaPelicula = Pelicula(
            nombre: _nombreController.text,
            imagen: _imagenController.text,
          );

          await PeliculaBLL.insert(nuevaPelicula);
          if (mounted) {
            Navigator.pushNamed(context, '/pelicula/list');
          }
        }
      },
      child: const Text('Enviar'),
    );
  }
}
