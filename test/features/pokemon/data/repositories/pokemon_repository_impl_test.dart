import 'package:dartz/dartz.dart';
import 'package:flutter_pokemon/core/error/exceptions.dart';
import 'package:flutter_pokemon/core/error/failures.dart';
import 'package:flutter_pokemon/core/platform/network_info.dart';
import 'package:flutter_pokemon/features/pokemon/data/datasources/pokemon_local_datasource.dart';
import 'package:flutter_pokemon/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:flutter_pokemon/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/pokemons.dart';

class MockRemoteDataSource extends Mock implements PokemonRemoteDatasource {}

class MockLocalDataSource extends Mock implements PokemonLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

main() {
  late PokemonRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PokemonRepositoryImpl(
      remoteDatasource: mockRemoteDataSource,
      localDatasource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getPokemonList', () {

    test('should check if the device is online', () async {
      // arrange
      when(() => mockRemoteDataSource.getPokemonList()).thenAnswer((_) async => pokemonMockList);
      when(() => mockLocalDataSource.cachePokemonList(any())).thenAnswer((_) async => null);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getPokemonList();
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() => when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true));

      test(
        'should return remote data when the call to remote data source is success:',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemonList()).thenAnswer((_) async => pokemonMockList);
          when(() => mockLocalDataSource.cachePokemonList(any())).thenAnswer((_) async => null);
          // Act
          final result = await repository.getPokemonList();
          // assert
          expect(result, equals(Right(pokemonMockList)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is success:',
            () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemonList()).thenAnswer((_) async => pokemonMockList);
          when(() => mockLocalDataSource.cachePokemonList(any())).thenAnswer((_) async => null);
          // Act
          await repository.getPokemonList();
          // assert
          verify(() => mockLocalDataSource.cachePokemonList(pokemonMockList));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccess:',
            () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemonList()).thenThrow(ServerException());
          when(() => mockLocalDataSource.cachePokemonList(any())).thenAnswer((_) async => null);
          // Act
          final result = await repository.getPokemonList();
          // assert
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );


    });

    group('device is offline', () {
      setUp(() => when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false));
    });
  });
}
