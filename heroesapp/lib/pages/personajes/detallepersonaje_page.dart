import 'package:buscador_de_peliculas/bll/peliculas_personajes_bll.dart';
import 'package:buscador_de_peliculas/bll/personaje_bll.dart';
import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/models/personaje.dart';
import 'package:buscador_de_peliculas/pages/personajes/agregarpeliculaform_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PersonajeDetallePage extends StatefulWidget {
  final int id;

  const PersonajeDetallePage({super.key, required this.id});

  @override
  State<PersonajeDetallePage> createState() => _PersonajeDetallePage();
}

class _PersonajeDetallePage extends State<PersonajeDetallePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Personaje'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.movie),
            onPressed: () async {
              Navigator.pushNamed(context, '/');
              setState(() {});
            },
          ),
        ],
      ),
      body: getBody(),
    );
  }

  FutureBuilder<Personaje> getBody() {
    return FutureBuilder(
      future: PersonajeBLL.selectById(widget.id),
      builder: (BuildContext context, AsyncSnapshot<Personaje> snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            print(snapshot.error);
          }
          return const Center(
            child: Text('Error al cargar el Personaje'),
          );
        }
        if (snapshot.hasData) {
          return getPersonajeDetalle(snapshot);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  SingleChildScrollView getPersonajeDetalle(AsyncSnapshot<Personaje> snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: SizedBox(
                  width: 400, child: Image.network(snapshot.data!.imagen))),
          SizedBox(
              width: 350,
              child: Row(
                children: [
                  Text(snapshot.data!.nombre),
                ],
              )),
          SizedBox(
            width: 350,
            height: 80,
            child: Row(
              children: [
                Text(
                  snapshot.data!.nombreSuperheroe,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Icon(Icons.cake),
                  Text(snapshot.data!.edad.toString()),
                ],
              ),
              Column(
                children: <Widget>[
                  const Icon(Icons.fitness_center),
                  Text(snapshot.data!.peso.toString()),
                ],
              ),
              Column(
                children: <Widget>[
                  const Icon(Icons.public),
                  Text(snapshot.data!.planeta.toString()),
                ],
              ),
              Column(
                children: <Widget>[
                  const Icon(Icons.height),
                  Text(snapshot.data!.altura.toString()),
                ],
              ),
            ],
          ),
          SizedBox(
              width: 300, child: Text('Historia: ${snapshot.data!.historia}')),
          const Text(
            'HABILIDADES:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text('Fuerza: ${snapshot.data!.fuerza}'),
          SizedBox(
            width: 300, // Establece el ancho que desees
            child: LinearProgressIndicator(
              value: snapshot.data!.fuerza / 200,
            ),
          ),
          Text('Velocidad: ${snapshot.data!.velocidad}'),
          SizedBox(
            width: 300, // Establece el ancho que desees
            child: LinearProgressIndicator(
              value: snapshot.data!.velocidad / 200,
            ),
          ),
          Text('Inteligencia: ${snapshot.data!.inteligencia}'),
          SizedBox(
            width: 300, // Establece el ancho que desees
            child: LinearProgressIndicator(
              value: snapshot.data!.inteligencia / 200,
            ),
          ),
          Text('Resistencia: ${snapshot.data!.resistencia}'),
          SizedBox(
            width: 300, // Establece el ancho que desees
            child: LinearProgressIndicator(
              value: snapshot.data!.resistencia / 200,
            ),
          ),
          Text('Agilidad: ${snapshot.data!.agilidad}'),
          SizedBox(
            width: 300, // Establece el ancho que desees
            child: LinearProgressIndicator(
              value: snapshot.data!.agilidad / 200,
            ),
          ),
          const Text(
            'PELICULAS:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          FutureBuilder<List<Pelicula>>(
            future:
                PeliculasPersonajesBLL.getPeliculasPorPersonajeId(widget.id),
            builder:
                (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.hasError) {
                if (kDebugMode) {
                  print(snapshot.error);
                }
                return const Center(
                  child: Text('Error al cargar las películas del personaje'),
                );
              }
              if (snapshot.hasData) {
                return SizedBox(
                  height: 200, // Ajusta la altura según tus necesidades
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: SizedBox(
                          width: 160,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 160,
                                child:
                                    Image.network(snapshot.data![index].imagen),
                              ), // Asume que tu modelo Pelicula tiene un campo imagen
                              Text(snapshot.data![index]
                                  .nombre), // Asume que tu modelo Pelicula tiene un campo nombre
                              // Agrega más campos si es necesario
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (snapshot.data != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarPeliculaPersonajeFormPage(
                        idPersonaje: snapshot.data!.id!),
                  ),
                );
              }
            },
            child: const Text('Agregar Película'),
          ),
        ],
      ),
    );
  }
}
