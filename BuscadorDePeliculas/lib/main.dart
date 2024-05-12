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
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    yearController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    yearController.removeListener(_onSearchChanged);
    yearController.dispose();
    super.dispose();
  }

  _onSearchChanged() async {
    if (searchController.text.isEmpty) {
      setState(() {
        resultadosBusqueda = [];
      });
    } else {
      resultadosBusqueda =
          await peliculaService.buscarPeliculas(searchController.text);
      setState(() {});
    }
  }

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
                        leading: pelicula.imageUrl != null &&
                                pelicula.imageUrl!.isNotEmpty
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${pelicula.imageUrl}',
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                              )
                            : const Icon(Icons
                                .error), // imagen por defecto si imageUrl es null
                        title: Text(pelicula.title ?? 'No disponible'),
                        subtitle: Text(
                          pelicula.releaseDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(pelicula.releaseDate!)
                              : 'No disponible',
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
