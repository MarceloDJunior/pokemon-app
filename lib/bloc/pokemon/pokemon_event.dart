part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {
  const PokemonEvent();
}

class GetPokemons extends PokemonEvent {
  const GetPokemons();
}

class FilterPokemons extends PokemonEvent {
  final String filterText;

  FilterPokemons(this.filterText);
}
