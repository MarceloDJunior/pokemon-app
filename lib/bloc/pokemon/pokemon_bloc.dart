import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/repositories/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;
  List<Pokemon> _pokemonList = [];

  PokemonBloc(this._pokemonRepository) : super(PokemonInitial());

  Pokemon? getPokemonByNumber(String number) {
    return _pokemonList.firstWhere((pokemon) => pokemon.num == number);
  }

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is GetPokemons) {
      try {
        yield PokemonLoading();
        await Future.delayed(Duration(milliseconds: 400));
        _pokemonList = await _pokemonRepository.getPokemons();
        yield PokemonLoaded(_pokemonList);
      } catch (e) {
        yield PokemonError('An error occured. Please try again later');
      }
    }

    if (event is FilterPokemons) {
      List<Pokemon> pokemons = _pokemonList
          .where((pokemon) => pokemon.name
              .toLowerCase()
              .contains(event.filterText.toLowerCase().trim()))
          .toList();
      yield PokemonLoaded(pokemons);
    }
  }
}
