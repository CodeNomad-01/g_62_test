import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/pokemon_controller.dart';

final pokemonProvider = StateNotifierProvider<PokemonController, PokemonState>(
  (ref) => PokemonController(),
);
