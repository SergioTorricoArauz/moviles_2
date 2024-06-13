import 'package:buscador_de_peliculas/bll/tipo_bll.dart';
import 'package:buscador_de_peliculas/models/tipo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TipoListPage extends StatefulWidget {
  const TipoListPage({super.key});

  @override
  State<TipoListPage> createState() => _TipoListPageState();
}

class _TipoListPageState extends State<TipoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tipos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navega al formulario de películas
              Navigator.pushNamed(context, '/tipo/form');
            },
          ),
        ],
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tipo/form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  FutureBuilder<List<Tipo>> getBody() {
    return FutureBuilder(
      future: TipoBLL.selectAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Tipo>> snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            print(snapshot.error);
          }
          return const Center(
            child: Text('Error al cargar los Tipos'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              var tipo = snapshot.data?[index];
              return ListTile(
                title: Text(tipo?.nombre ?? ''),
                subtitle: Text(tipo?.id.toString() ?? ''),
                onTap: () {
                  Navigator.pushNamed(context, '/tipo/form/${tipo?.id}');
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
