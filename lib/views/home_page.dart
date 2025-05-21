import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_provider.dart';
import 'pokemon_list_screen.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokemonProvider);
    final controller = ref.read(pokemonProvider.notifier);

    List<Widget> _screens = [
      PokemonListScreen(),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.catching_pokemon, size: 100, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Pantalla 2 - Vacía',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videogame_asset, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Pantalla 3 - También vacía',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon App MVC'),
        actions: [
          if (state.currentIndex == 0)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => controller.fetchPokemonData(),
            ),
        ],
      ),
      body: _screens[state.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state.currentIndex,
        onTap: (index) => controller.setCurrentIndex(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokémon',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Pantalla 2'),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Pantalla 3',
          ),
        ],
      ),
      floatingActionButton:
          state.currentIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('¡Esta es una aplicación con MVC!')),
                  );
                },
                child: Icon(Icons.info),
              )
              : null,
    );
  }
}
