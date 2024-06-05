import 'dart:io';

import 'package:buscador_de_peliculas/pages/peliculas/peliculaform_page.dart';
import 'package:buscador_de_peliculas/pages/peliculas/peliculalist_page.dart';
import 'package:buscador_de_peliculas/pages/personajes/personajelist_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          '/': (context) => const PersonajeListPage(),
          '/personaje/form': (context) => const PersonajeListPage(),
          '/personaje/form/:id': (context) => const PersonajeListPage(),
          '/pelicula/form': (context) => const PeliculaForm(),
          '/pelicula/list': (context) => const PeliculaListPage(),
        };
        WidgetBuilder? builder = routes[settings.name];
        if (builder == null) {
          // Handle unknown route
          throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
