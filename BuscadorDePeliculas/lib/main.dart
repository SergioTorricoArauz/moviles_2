import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/services/pelicula_service.dart'; // Importa tu servicio aquí
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final peliculaService = PeliculaService();
  final searchController = TextEditingController();
  final yearController =
      TextEditingController(); // Nuevo controlador para el año

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Buscar película...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  String movieName = searchController
                      .text; // Obtén el nombre de la película del controlador
                  peliculaService.buscarPeliculas(
                      movieName); // Busca la película con el nombre dado

                  // Actualiza el estado para mostrar los resultados de la búsqueda
                  (context as Element).markNeedsBuild();
                },
              ),
              Expanded(
                child: TextField(
                  controller: yearController,
                  decoration: const InputDecoration(
                    hintText: 'Año de lanzamiento...',
                  ),
                  keyboardType: TextInputType.number, // Solo permite números
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Actualiza el estado para mostrar los resultados de la búsqueda
                  (context as Element).markNeedsBuild();
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Pelicula>>(
            future: yearController.text.isEmpty
                ? searchController.text.isEmpty
                    ? peliculaService.obtenerListaPeliculas()
                    : peliculaService.buscarPeliculas(searchController.text)
                : peliculaService.buscarPeliculasPorAno(int.parse(yearController
                    .text)), // Busca por año si hay un año ingresado
            builder:
                (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                var peliculas = snapshot.data!;
                return ListView.builder(
                  itemCount: peliculas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                            'https://image.tmdb.org/t/p/w200${peliculas[index].imageUrl}',
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error)),
                        title: Text(peliculas[index].title ?? 'No disponible'),
                        subtitle: Text(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(
                              peliculas[index].releaseDate?.toString() ??
                                  'No disponible')),
                        ),
                        onTap: () {
                          int id = int.parse(peliculas[index].id.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPelicula(
                                peliculaService: peliculaService,
                                id: id,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

class DetailPelicula extends StatelessWidget {
  final PeliculaService peliculaService;
  final int id;

  const DetailPelicula(
      {Key? key, required this.peliculaService, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Pelicula>(
            future: peliculaService.obtenerPeliculasPorId(id),
            builder: (BuildContext context, AsyncSnapshot<Pelicula> snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original${snapshot.data!.backdropPath} ?? No disponible',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity:
                          0.8, // Ajusta este valor para cambiar la opacidad
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original${snapshot.data!.imageUrl} ?? No disponible',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(snapshot.data!.id.toString()),
                                    Text(
                                      ' ${snapshot.data!.title ?? 'No disponible'}',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors
                                              .white), // Título más grande
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Fecha de lanzamiento: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(snapshot
                                                      .data!.releaseDate
                                                      ?.toString() ??
                                                  'No disponible')),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Duración: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${snapshot.data!.runtime?.toString() ?? 'No disponible'} minutos',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Géneros: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.genres?.join(', ') ??
                                              'No disponible',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Director: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.name ??
                                              'No disponible',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Descripción: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            snapshot.data!.overview ??
                                                'No disponible',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Popularidad: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.popularity
                                                  ?.toString() ??
                                              'No disponible',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Calificación: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.voteAverage
                                                  ?.toString() ??
                                              'No disponible',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
