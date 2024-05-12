import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/pages/detalle_pelicula.dart';
import 'package:buscador_de_peliculas/services/pelicula_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final peliculaService = PeliculaService();
  final searchController = TextEditingController();
  final yearController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int pagina = 1;
  List<Pelicula> peliculas = [];
  List<Pelicula> resultadosBusqueda = [];

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
                  String movieName = searchController.text;
                  try {
                    resultadosBusqueda =
                        await peliculaService.buscarPeliculas(movieName);
                    setState(() {});
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
                onPressed: () async {
                  if (yearController.text.isNotEmpty) {
                    resultadosBusqueda = await peliculaService
                        .buscarPeliculasPorAno(int.parse(yearController.text));
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: resultadosBusqueda.isNotEmpty
                      ? resultadosBusqueda.length
                      : peliculas.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pelicula pelicula = resultadosBusqueda.isNotEmpty
                        ? resultadosBusqueda[index]
                        : peliculas[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                            'https://image.tmdb.org/t/p/w200${pelicula.imageUrl}',
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error)),
                        title: Text(pelicula.title ?? 'No disponible'),
                        subtitle: Text(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(
                              pelicula.releaseDate?.toString() ??
                                  'No disponible')),
                        ),
                        onTap: () {
                          int id = int.parse(pelicula.id.toString());
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
                ),
              ),
              ElevatedButton(
                child: const Text('Cargar más'),
                onPressed: () async {
                  pagina++;
                  List<Pelicula> masPeliculas =
                      await peliculaService.obtenerListaPeliculas(pagina);
                  setState(() {
                    peliculas.addAll(masPeliculas);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
