import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/pages/detalle_pelicula.dart';
import 'package:buscador_de_peliculas/services/pelicula_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  runApp(MainApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    Logger('MainApp').info('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
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
    _retrieveSearch();
    searchController.addListener(_onSearchChanged);
    yearController.addListener(_onSearchChanged);
  }

  _retrieveSearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastSearch = prefs.getString('last_search');
    String? lastYearSearch = prefs.getString('last_year_search');

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (lastSearch != null) {
        searchController.text = lastSearch;
      }

      if (lastYearSearch != null) {
        yearController.text = lastYearSearch;
      }
    });
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (searchController.text.isEmpty) {
      setState(() {
        resultadosBusqueda = [];
      });

      // Verificar si la búsqueda está almacenada
      if (prefs.containsKey('last_search')) {
        // La búsqueda está almacenada
        Logger('MainApp').info('La búsqueda está almacenada.');
      } else {
        // La búsqueda no está almacenada
        Logger('MainApp').info('La búsqueda no está almacenada.');
      }
    } else {
      resultadosBusqueda =
          await peliculaService.buscarPeliculas(searchController.text);
      setState(() {});

      // Almacenar la búsqueda en el almacenamiento local
      prefs.setString('last_search', searchController.text);

      // Registrar la búsqueda almacenada
      Logger('MainApp').info('Búsqueda almacenada: ${searchController.text}');
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
