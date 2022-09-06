import '../../domain/entities/pokemon_list_info.dart';

abstract class PokemonLocalDatasource {
  /// calls the https://pokeapi.co/api/v2/pokemon api
  Future<List<PokemonListInfo>> getPokemonList();

  Future<void> cachePokemonList(List<PokemonListInfo> listToCache);
}
