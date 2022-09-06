import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/pokemon.dart';
import '../entities/pokemon_list_info.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonListInfo>>> getPokemonList();
  Future<Either<Failure, Pokemon>> getPokemonByName(String name);
}
