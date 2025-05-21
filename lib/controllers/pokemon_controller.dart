import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pokemon.dart';

class PokemonState {
  final List<Pokemon> pokemonList;
  final bool isLoading;
  final int currentIndex;

  PokemonState({
    required this.pokemonList,
    required this.isLoading,
    required this.currentIndex,
  });

  PokemonState copyWith({
    List<Pokemon>? pokemonList,
    bool? isLoading,
    int? currentIndex,
  }) {
    return PokemonState(
      pokemonList: pokemonList ?? this.pokemonList,
      isLoading: isLoading ?? this.isLoading,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class PokemonController extends StateNotifier<PokemonState> {
  PokemonController()
    : super(PokemonState(pokemonList: [], isLoading: false, currentIndex: 0)) {
    fetchPokemonData();
  }

  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  Future<void> fetchPokemonData() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List results = data['results'];
        List<Pokemon> tempList = [];

        for (var item in results) {
          final detailResponse = await http.get(Uri.parse(item['url']));
          if (detailResponse.statusCode == 200) {
            final detailData = json.decode(detailResponse.body);
            tempList.add(
              Pokemon.fromDetailJson(detailData, item['name'], item['url']),
            );
          } else {
            tempList.add(Pokemon.fromListJson(item));
          }
        }
        state = state.copyWith(pokemonList: tempList);
      }
    } catch (e) {
      // Handle error
    }
    state = state.copyWith(isLoading: false);
  }
}
