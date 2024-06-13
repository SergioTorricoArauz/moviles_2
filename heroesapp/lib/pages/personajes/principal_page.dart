import 'package:buscador_de_peliculas/bll/pelicula_bll.dart';
import 'package:buscador_de_peliculas/models/personaje.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  FutureBuilder<List<Personaje>> buildHeroesCards() {
    return FutureBuilder<List<Personaje>>(
      future: PeliculaBLL.selectByType(1), // 1 es el idTipo para los héroes
      builder: (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
        print('Estado del snapshot: ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Error: ${snapshot.error}'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          return const SizedBox
              .shrink(); // Retorna un widget vacío después de mostrar el diálogo
        } else if (snapshot.hasData && snapshot.data != null) {
          print('Datos recuperados: ${snapshot.data}');
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Personaje personaje = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(personaje.nombre),
                  subtitle: Text(personaje.idTipo.toString()),
                  // Agrega aquí más detalles del personaje si lo deseas
                ),
              );
            },
          );
        } else {
          return const Text('Estado desconocido');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Héroes'),
      ),
      body: buildHeroesCards(),
    );
  }
}
