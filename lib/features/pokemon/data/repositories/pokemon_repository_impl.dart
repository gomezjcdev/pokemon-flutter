import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_list_info.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_datasource.dart';
import '../datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final PokemonRemoteDatasource remoteDatasource;
  final PokemonLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PokemonListInfo>>> getPokemonList() async {
    networkInfo.isConnected;
    try {
      final remotePokemonList = await remoteDatasource.getPokemonList();
      localDatasource.cachePokemonList(remotePokemonList);
      return Right(remotePokemonList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonByName(String name) {
    // TODO: implement getPokemonByName
    throw UnimplementedError();
  }
}
