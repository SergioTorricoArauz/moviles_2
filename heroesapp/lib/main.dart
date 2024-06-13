import 'dart:io';

import 'package:buscador_de_peliculas/pages/peliculas/peliculaform_page.dart';
import 'package:buscador_de_peliculas/pages/peliculas/peliculalist_page.dart';
import 'package:buscador_de_peliculas/pages/personajes/personajeform_page.dart';
import 'package:buscador_de_peliculas/pages/personajes/personajelist_page.dart';
import 'package:buscador_de_peliculas/pages/tipos/tipoform_page.dart';
import 'package:buscador_de_peliculas/pages/tipos/tiposlist_page.dart';
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
        // Dividir la ruta en partes
        var parts = settings.name?.split('/') ?? [];

        if (parts.length > 1) {
          switch (parts[1]) {
            // Cambiar a parts[1]
            case '':
              return MaterialPageRoute(
                  builder: (ctx) => const PersonajeListPage());
            case 'personaje':
              if (parts.length > 2 && parts[2] == 'form') {
                var id = parts.length > 3 ? int.tryParse(parts[3]) : null;
                return MaterialPageRoute(
                    builder: (ctx) => PersonajeForm(id: id));
              } else if (parts.length > 2 && parts[2] == 'list') {
                return MaterialPageRoute(
                    builder: (ctx) => const PersonajeListPage());
              } else if (parts.length == 2 && parts[1] == 'form') {
                return MaterialPageRoute(
                    builder: (ctx) => const PersonajeForm());
              }
              break;
            case 'pelicula':
              if (parts.length > 2 && parts[2] == 'form') {
                var id = parts.length > 3 ? int.tryParse(parts[3]) : null;
                return MaterialPageRoute(
                    builder: (ctx) => PeliculaForm(idPelicula: id));
              } else if (parts.length > 2 && parts[2] == 'list') {
                return MaterialPageRoute(
                    builder: (ctx) => const PeliculaListPage());
              } else if (parts.length == 2 && parts[2] == 'form') {
                return MaterialPageRoute(
                    builder: (ctx) => const PeliculaForm());
              }
              break;
            case 'tipo':
              if (parts.length > 2 && parts[2] == 'form') {
                var id = parts.length > 3 ? int.tryParse(parts[3]) : null;
                return MaterialPageRoute(
                    builder: (ctx) => TipoFormPage(id: id));
              } else if (parts.length > 2 && parts[2] == 'list') {
                return MaterialPageRoute(
                    builder: (ctx) => const TipoListPage());
              } else if (parts.length == 2 && parts[2] == 'form') {
                return MaterialPageRoute(
                    builder: (ctx) => const TipoFormPage());
              }
              break;
          }
        }

        // Si ninguna ruta coincide, lanzar una excepción
        throw Exception('Invalid route: ${settings.name}');
      },
    );
  }
}
