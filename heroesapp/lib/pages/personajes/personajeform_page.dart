import 'package:buscador_de_peliculas/bll/personaje_bll.dart';
import 'package:buscador_de_peliculas/models/personaje.dart';
import 'package:flutter/material.dart';

class PersonajeForm extends StatefulWidget {
  const PersonajeForm({super.key, this.id});

  final int? id;

  @override
  State<PersonajeForm> createState() => _PersonajeFormState();
}

class _PersonajeFormState extends State<PersonajeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _nombreSuperheroeController = TextEditingController();
  final _edadController = TextEditingController();
  final _imagenController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _planetaController = TextEditingController();
  final _historiaController = TextEditingController();
  final _fuerzaController = TextEditingController();
  final _inteligenciaController = TextEditingController();
  final _agilidadController = TextEditingController();
  final _resistenciaController = TextEditingController();
  final _velocidadController = TextEditingController();
  final _idPeliculaController = TextEditingController();
  final _idTipoController = TextEditingController();
  Personaje? personaje;

  @override
  void initState() {
    super.initState();
    _loadPersonaje();
  }

  _loadPersonaje() async {
    if (widget.id != null) {
      personaje = await PersonajeBLL.selectById(widget.id!);
      _nombreController.text = personaje!.nombre;
      _nombreSuperheroeController.text = personaje!.nombreSuperheroe;
      _edadController.text = personaje!.edad.toString();
      _imagenController.text = personaje!.imagen;
      _pesoController.text = personaje!.peso.toString();
      _alturaController.text = personaje!.altura.toString();
      _planetaController.text = personaje!.planeta;
      _historiaController.text = personaje!.historia;
      _fuerzaController.text = personaje!.fuerza.toString();
      _inteligenciaController.text = personaje!.inteligencia.toString();
      _agilidadController.text = personaje!.agilidad.toString();
      _resistenciaController.text = personaje!.resistencia.toString();
      _velocidadController.text = personaje!.velocidad.toString();
      _idPeliculaController.text = personaje!.idPelicula.toString();
      _idTipoController.text = personaje!.idTipo.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Personaje'),
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
            controller: _nombreSuperheroeController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Nombre Superheroe',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre de superhéroe';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _edadController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Edad',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una edad';
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
          TextFormField(
            controller: _pesoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Peso',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un peso';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _alturaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Altura',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una altura';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _planetaController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Planeta',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un planeta';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _historiaController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Historia',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una historia';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _fuerzaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Fuerza',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una fuerza';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _inteligenciaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Inteligencia',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una inteligencia';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _agilidadController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Agilidad',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una agilidad';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _resistenciaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Resistencia',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una resistencia';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _velocidadController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Velocidad',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una velocidad';
              }
              return null;
            },
          ),
          FutureBuilder<List<int>>(
            future: PersonajeBLL.selectAllIds(),
            builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
              if (snapshot.hasData) {
                return DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Id Película',
                  ),
                  items: snapshot.data!.asMap().entries.map((entry) {
                    int idx = entry.key;
                    int id = entry.value;
                    return DropdownMenuItem<int>(
                      value: idx,
                      child: Text(id.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      _idPeliculaController.text =
                          snapshot.data![newValue!].toString();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un id de película';
                    }
                    return null;
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Tipo',
            ),
            items: const [
              DropdownMenuItem(
                value: 1,
                child: Text("Héroe"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("Villano"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("Antivillano"),
              ),
            ],
            onChanged: (int? newValue) {
              setState(() {
                _idTipoController.text = newValue.toString();
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Por favor seleccione un tipo';
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
          Personaje nuevoPersonaje = Personaje(
            nombre: _nombreController.text,
            nombreSuperheroe: _nombreSuperheroeController.text,
            edad: int.parse(_edadController.text),
            imagen: _imagenController.text,
            peso: int.parse(_pesoController.text),
            altura: int.parse(_alturaController.text),
            planeta: _planetaController.text,
            historia: _historiaController.text,
            fuerza: int.parse(_fuerzaController.text),
            inteligencia: int.parse(_inteligenciaController.text),
            agilidad: int.parse(_agilidadController.text),
            resistencia: int.parse(_resistenciaController.text),
            velocidad: int.parse(_velocidadController.text),
            idPelicula: int.parse(_idPeliculaController.text),
            idTipo: int.parse(_idTipoController.text),
          );

          if (personaje != null) {
            nuevoPersonaje.id = personaje!.id;
            await PersonajeBLL.update(nuevoPersonaje);
          } else {
            await PersonajeBLL.insert(nuevoPersonaje);
          }

          if (mounted) {
            Navigator.pushNamed(context, '/');
          }
        }
      },
      child: const Text('Enviar'),
    );
  }
}
