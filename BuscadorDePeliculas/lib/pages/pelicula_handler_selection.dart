import 'package:buscador_de_peliculas/models/pelicula.dart';

class PeliculaSelectionHandler {
  List<Pelicula> peliculasSeleccionadas = [];

  void onPeliculaSelected(Pelicula pelicula) {
    peliculasSeleccionadas.add(pelicula);
  }
}
