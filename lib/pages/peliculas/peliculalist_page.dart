import 'package:flutter/material.dart';
import 'package:heroes_app/bll/pelicula_bll.dart';
import 'package:heroes_app/models/pelicula.dart';

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
            icon: const Icon(Icons.delete),
            onPressed: () async {
              //await PeliculaDAL.deleteDB();
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
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Pelicula pelicula = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Column(
                    children: <Widget>[
                      Text(pelicula.nombre),
                      SizedBox(
                        width: 100.0, // Ancho de la imagen
                        height: 100.0, // Altura de la imagen
                        child:
                            Image.network(pelicula.imagen, fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
