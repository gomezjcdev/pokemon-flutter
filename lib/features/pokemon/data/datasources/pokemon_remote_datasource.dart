import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_list_info.dart';

abstract class PokemonRemoteDatasource {
  /// calls the https://pokeapi.co/api/v2/pokemon api
  Future<List<PokemonListInfo>> getPokemonList();

  /// calls the https://pokeapi.co/api/v2/pokemon/{name} api
  Future<Pokemon> getPokemonByName(String name);
}
