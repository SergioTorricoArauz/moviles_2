import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/pages/detalle_pelicula.dart';
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
  final yearController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
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
                onPressed: () async {
                  String movieName = searchController
                      .text; // Obtén el nombre de la película del controlador
                  try {
                    await peliculaService.buscarPeliculas(
                        movieName); // Busca la película con el nombre dado
                    // Actualiza el estado para mostrar los resultados de la búsqueda
                    (context as Element).markNeedsBuild();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Ocurrió un error al buscar las películas: $e'),
                      ),
                    );
                  }
                },
              ),
              Expanded(
                child: TextField(
                  controller: yearController,
                  decoration: const InputDecoration(
                    hintText: 'Año de lanzamiento...',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
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
                : peliculaService
                    .buscarPeliculasPorAno(int.parse(yearController.text)),
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
