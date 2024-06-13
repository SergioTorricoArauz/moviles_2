import 'package:buscador_de_peliculas/bll/peliculas_personajes_BLL.dart';
import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/models/peliculas_personaje.dart';
import 'package:flutter/material.dart';

class AgregarPeliculaPersonajeFormPage extends StatefulWidget {
  const AgregarPeliculaPersonajeFormPage(
      {super.key, this.id, required this.idPersonaje});

  final int? id;
  final int idPersonaje;

  @override
  // ignore: library_private_types_in_public_api
  _AgregarPeliculaPersonajeFormPageState createState() =>
      _AgregarPeliculaPersonajeFormPageState();
}

class _AgregarPeliculaPersonajeFormPageState
    extends State<AgregarPeliculaPersonajeFormPage> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedPeliculaId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null
            ? 'Nueva PeliculaPersonaje'
            : 'Editar PeliculaPersonaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('ID del Personaje seleccionado: ${widget.idPersonaje}'),
              TextField(
                controller: TextEditingController(
                    text: _selectedPeliculaId?.toString()),
                decoration:
                    const InputDecoration(hintText: 'Ingrese ID de Película'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _selectedPeliculaId = int.tryParse(value);
                  });
                },
              ), // Muestra el ID del personaje seleccionado
              FutureBuilder<List<Pelicula>>(
                future: PeliculasPersonajesBLL.getPeliculasPorPersonajeId(
                    widget.idPersonaje),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    int? selectedPeliculaIndex;
                    return DropdownButton<int>(
                      value: selectedPeliculaIndex,
                      hint: const Text('Seleccione Película'),
                      items: snapshot.data!.asMap().entries.map((entry) {
                        int index = entry.key;
                        Pelicula pelicula = entry.value;
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(pelicula.nombre),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedPeliculaIndex = newValue;
                          _selectedPeliculaId = snapshot.data![newValue!].id;
                        });
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var peliculaPersonaje = PeliculasPersonajes(
                      id: widget.id,
                      idPelicula: _selectedPeliculaId!,
                      idPersonaje: widget.idPersonaje,
                    );
                    if (widget.id == null) {
                      await PeliculasPersonajesBLL.insert(peliculaPersonaje);
                    } else {
                      await PeliculasPersonajesBLL.update(peliculaPersonaje);
                    }
                    Navigator.pop(context);
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
