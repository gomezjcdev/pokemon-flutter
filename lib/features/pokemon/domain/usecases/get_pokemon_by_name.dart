import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonByName implements UseCase<Pokemon, Params> {
  final PokemonRepository repository;

  GetPokemonByName(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(Params params) async {
    return await repository.getPokemonByName(params.name);
  }

}

class Params {
  final String name;

  Params(this.name);
}