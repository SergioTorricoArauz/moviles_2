import 'package:buscador_de_peliculas/bll/pelicula_bll.dart';
import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PeliculaListPage extends StatefulWidget {
  const PeliculaListPage({super.key});

  @override
  State<PeliculaListPage> createState() => _PeliculaListPageState();
}

class _PeliculaListPageState extends State<PeliculaListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Peliculas'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/pelicula/form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  FutureBuilder<List<Pelicula>> getBody() {
    return FutureBuilder(
      future: PeliculaBLL.selectAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            print(snapshot.error);
          }
          return const Center(
            child: Text('Error al cargar los Personajes'),
          );
        }
        if (snapshot.hasData) {
          return getPersonajeList(snapshot);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView getPersonajeList(AsyncSnapshot<List<Pelicula>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Pelicula? personaje = snapshot.data?[index];
        if (personaje != null) {
          return FutureBuilder<Pelicula?>(
            future: PeliculaBLL.selectById(personaje.id ?? 0),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Pelicula? pelicula = snapshot.data;
                return Center(
                  child: SizedBox(
                    width: 280.0,
                    height: 150.0,
                    child: Center(
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/pelicula/form/${pelicula!.id}');
                          },
                          title: Text(
                              '${pelicula?.id ?? 'Sin ID'}${pelicula?.nombre ?? 'Sin nombre'}'), // Aquí se muestra el ID
                          subtitle: pelicula?.imagen != null
                              ? SizedBox(
                                  width: 100.0,
                                  height: 90.0,
                                  child: pelicula?.imagen != null &&
                                          pelicula!.imagen.startsWith('http')
                                      ? Center(
                                          child: Image.network(pelicula.imagen,
                                              fit: BoxFit.cover),
                                        )
                                      : const Text('Imagen no disponible'),
                                )
                              : const Text('Sin imagen'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              if (pelicula?.id != null) {
                                await PeliculaBLL.delete(pelicula!.id ?? 0);
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
