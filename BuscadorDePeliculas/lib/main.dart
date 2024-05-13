import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/pages/detalle_pelicula.dart';
import 'package:buscador_de_peliculas/pages/pelicula_handler_selection.dart';
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
  PeliculaSelectionHandler peliculaSelectionHandler =
      PeliculaSelectionHandler();
  List<String> historialBusquedas = [];

  @override
  void initState() {
    super.initState();
    _retrieveSearch();
    // searchController.addListener(_onSearchChanged);
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

  void onPeliculaSelected(Pelicula pelicula) {
    peliculaSelectionHandler.onPeliculaSelected(pelicula);
  }

  @override
  void dispose() {
    // searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

/*
  _onSearchChanged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (searchController.text.isEmpty) {
      setState(() {
        resultadosBusqueda = [];
      });
    } else {
      resultadosBusqueda =
          await peliculaService.buscarPeliculas(searchController.text);
      setState(() {});

      // Almacenar la búsqueda en el almacenamiento local
      List<String> historialBusquedas =
          prefs.getStringList('historial_busquedas') ?? [];
      historialBusquedas.add(searchController.text);
      prefs.setStringList('historial_busquedas', historialBusquedas);

      // Registrar la búsqueda almacenada
      Logger('MainApp').info('Búsqueda almacenada: ${searchController.text}');
    }
  }
*/

  _onSearchButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (searchController.text.isNotEmpty) {
      resultadosBusqueda =
          await peliculaService.buscarPeliculas(searchController.text);
      setState(() {});

      // Almacenar la búsqueda en el almacenamiento local
      List<String> historialBusquedas =
          prefs.getStringList('historial_busquedas') ?? [];
      historialBusquedas.add(searchController.text);
      prefs.setStringList('historial_busquedas', historialBusquedas);

      // Registrar la búsqueda almacenada
      Logger('MainApp').info('Búsqueda almacenada: ${searchController.text}');
    }
  }

  _onYearSearchButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (yearController.text.isNotEmpty) {
      resultadosBusqueda = await peliculaService
          .buscarPeliculasPorAno(int.parse(yearController.text));
      setState(() {});

      // Almacenar la búsqueda en el almacenamiento local
      List<String> historialBusquedasPorAno =
          prefs.getStringList('historial_busquedas_por_ano') ?? [];
      historialBusquedasPorAno.add(yearController.text);
      prefs.setStringList(
          'historial_busquedas_por_ano', historialBusquedasPorAno);

      // Registrar la búsqueda almacenada
      Logger('MainApp')
          .info('Búsqueda por año almacenada: ${yearController.text}');
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
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _onSearchButtonPressed,
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
                onPressed: _onYearSearchButtonPressed,
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
