import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_list_info.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonList implements UseCase<List<PokemonListInfo>, NoParams> {
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  @override
  Future<Either<Failure, List<PokemonListInfo>>> call(NoParams params) async {
    return await repository.getPokemonList();
  }

}

class NoParams {}