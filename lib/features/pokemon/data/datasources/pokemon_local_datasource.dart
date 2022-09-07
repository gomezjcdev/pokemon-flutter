import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_list_info.dart';

abstract class PokemonLocalDatasource {
  Future<List<PokemonListInfo>> getPokemonList();

  Future<Pokemon> getPokemonByName(String name);

  Future<void> cachePokemonList(List<PokemonListInfo> listToCache);

  Future<void> cacheLastPokemonDetail(Pokemon pokemonToCache);
}

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  final SharedPreferences sharedPreferences;

  PokemonLocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheLastPokemonDetail(Pokemon pokemonToCache) {
    // TODO: implement cacheLastPokemonDetail
    throw UnimplementedError();
  }

  @override
  Future<void> cachePokemonList(List<PokemonListInfo> listToCache) {
    // TODO: implement cachePokemonList
    throw UnimplementedError();
  }

  @override
  Future<Pokemon> getPokemonByName(String name) {
    // TODO: implement getPokemonByName
    throw UnimplementedError();
  }

  @override
  Future<List<PokemonListInfo>> getPokemonList() {
    // TODO: implement getPokemonList
    throw UnimplementedError();
  }
}
