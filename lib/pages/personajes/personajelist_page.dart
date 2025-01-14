import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroes_app/bll/personaje_bll.dart';
import 'package:heroes_app/dal/personaje_dal.dart';
import 'package:heroes_app/models/personaje.dart';

class PersonajeListPage extends StatefulWidget {
  const PersonajeListPage({super.key});

  @override
  State<PersonajeListPage> createState() => _PersonajeListPageState();
}

class _PersonajeListPageState extends State<PersonajeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Personajes'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await PersonajeDAL.deleteDB();
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
            Personaje personaje = Personaje(
              nombre: 'Personaje 1',
              nombreSuperheroe: 'Spiderman',
              edad: 25,
              imagen: 'imagen',
              peso: 70,
              altura: 180,
              planeta: 'Tierra',
              historia: 'Historia',
              fuerza: 10,
              inteligencia: 10,
              agilidad: 10,
              resistencia: 10,
              velocidad: 10,
              idPelicula: 1,
              idTipo: 1,
            );
            PersonajeBLL.insert(personaje);
            setState(() {});
          },
          child: const Icon(Icons.add),
        ));
  }

  FutureBuilder<List<Personaje>> getBody() {
    return FutureBuilder(
      future: PersonajeBLL.selectAll(),
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
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Personaje? personaje = snapshot.data?[index];
        if (personaje != null) {
          return FutureBuilder<Personaje>(
            future: PersonajeBLL.selectById(personaje.id ?? 0),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Personaje? personaje = snapshot.data;
                return ListTile(
                  title: Text(personaje?.nombre ?? 'Sin nombre'),
                  subtitle: Text(
                      'Nombre Superheroe: ${personaje?.nombreSuperheroe ?? 'Sin nombre de superhéroe'}, Edad: ${personaje?.edad ?? 'Sin edad'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      if (personaje?.id != null) {
                        await PersonajeBLL.delete(personaje!.id ?? 0);
                        setState(() {});
                      }
                    },
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
