part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {
  const PokemonState();
}

class PokemonInitial extends PokemonState {
  const PokemonInitial();
}

class PokemonLoading extends PokemonState {
  const PokemonLoading();
}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemonList;

  const PokemonLoaded(this.pokemonList);
}

class PokemonError extends PokemonState {
  final String message;
  const PokemonError(this.message);
}
