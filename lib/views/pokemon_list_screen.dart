import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_provider.dart';

class PokemonListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokemonProvider);

    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: state.pokemonList.length,
      itemBuilder: (context, index) {
        final pokemon = state.pokemonList[index];
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(pokemon.name.toUpperCase()),
                  content: Container(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        pokemon.imageUrl != null
                            ? Image.network(
                              pokemon.imageUrl!,
                              height: 200,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.error),
                            )
                            : Container(),
                        SizedBox(height: 10),
                        Text('Altura: ${pokemon.height ?? '?'} dm'),
                        Text('Peso: ${pokemon.weight ?? '?'} hg'),
                        Text('Tipo: ${pokemon.type ?? '?'}'),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cerrar'),
                    ),
                  ],
                );
              },
            );
          },
          child: Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  pokemon.imageUrl != null
                      ? Image.network(
                        pokemon.imageUrl!,
                        height: 100,
                        width: 100,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              height: 100,
                              width: 100,
                              color: Colors.grey[300],
                              child: Icon(Icons.error),
                            ),
                      )
                      : Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey[300],
                        child: CircularProgressIndicator(),
                      ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pokemon.name.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        if (pokemon.id != null) ...[
                          SizedBox(height: 8),
                          Text('ID: #${pokemon.id}'),
                          Text('Tipo: ${pokemon.type}'),
                          Text('Altura: ${pokemon.height} dm'),
                          Text('Peso: ${pokemon.weight} hg'),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
