import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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

class Params extends Equatable {
  final String name;

  const Params(this.name);

  @override
  List<Object?> get props => [];
}