import 'package:buscador_de_peliculas/bll/personaje_bll.dart';
import 'package:buscador_de_peliculas/dal/personaje_dal.dart';
//import 'package:buscador_de_peliculas/dal/personaje_dal.dart';
import 'package:buscador_de_peliculas/models/personaje.dart';
import 'package:buscador_de_peliculas/pages/personajes/detallepersonaje_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PersonajeListPage extends StatefulWidget {
  const PersonajeListPage({super.key});

  @override
  State<PersonajeListPage> createState() => _PersonajeListPageState();
}

class _PersonajeListPageState extends State<PersonajeListPage> {
  String query = '';
  Future<List<Personaje>>? searchResultsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personajes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Buscar Personaje'),
                    content: TextField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                          searchResultsFuture =
                              PersonajeDAL.searchPersonajes(query);
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nombre del Personaje',
                      ),
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              Navigator.pushReplacementNamed(context, '/tipo/list');
            },
          ),
          IconButton(
            icon: const Icon(Icons.movie),
            onPressed: () async {
              Navigator.pushNamed(context, '/pelicula/list');
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navega al formulario de películas
              Navigator.pushNamed(context, '/pelicula/form');
            },
          ),
        ],
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/personaje/form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  FutureBuilder<List<Personaje>> getBody() {
    return FutureBuilder(
      future: query.isEmpty
          ? PersonajeBLL.selectAll()
          : PersonajeDAL.searchPersonajes(query),
      builder: (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
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

  ListView getPersonajeList(AsyncSnapshot<List<Personaje>> snapshot) {
    return ListView.builder(
      scrollDirection:
          Axis.horizontal, // Cambia la dirección del scroll a horizontal
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Personaje? personaje = snapshot.data?[index];
        if (personaje != null) {
          return FutureBuilder<Personaje>(
            future: PersonajeBLL.selectById(personaje.id ?? 0),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Personaje? personaje = snapshot.data;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PersonajeDetallePage(id: personaje?.id ?? 0),
                      ),
                    );
                  },
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Card(
                        child: SizedBox(
                          width: 280.0,
                          height: 150.0,
                          child: ListTile(
                            title: Text(
                                '${personaje?.id ?? 'Sin ID'}${personaje?.nombre ?? 'Sin nombre'} ${personaje?.idTipo ?? 'Sin tipo'}'),
                            subtitle: Image.network(
                              personaje?.imagen ?? 'url_de_imagen_por_defecto',
                              width: 100, // Ancho de la imagen
                              height: 100, // Altura de la imagen
                              fit: BoxFit
                                  .cover, // Esto es para que la imagen se ajuste al tamaño especificado
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Esto asegura que la fila no ocupe todo el espacio disponible
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    if (personaje?.id != null) {
                                      await PersonajeBLL.delete(
                                          personaje!.id ?? 0);
                                      setState(() {});
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/personaje/form/${personaje?.id}',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const ListTile(
                  title: Text('Error: no se pudo cargar el personaje'),
                );
              }
              return const CircularProgressIndicator();
            },
          );
        }
        return const ListTile(
          title: Text('Error: personaje no encontrado'),
        );
      },
    );
  }
}
