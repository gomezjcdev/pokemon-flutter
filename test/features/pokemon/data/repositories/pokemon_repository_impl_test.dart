import 'package:dartz/dartz.dart';
import 'package:flutter_pokemon/core/error/exceptions.dart';
import 'package:flutter_pokemon/core/error/failures.dart';
import 'package:flutter_pokemon/core/network/network_info.dart';
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

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() => when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true));

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() => when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false));

      body();
    });
  }

  group('getPokemonList', () {
    test('should check if the device is online', () async {
      // arrange
      when(() => mockRemoteDataSource.getPokemonList())
          .thenAnswer((_) async => pokemonMockList);
      when(() => mockLocalDataSource.cachePokemonList(any()))
          .thenAnswer((_) async => null);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getPokemonList();
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is success:',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemonList())
              .thenAnswer((_) async => pokemonMockList);
          when(() => mockLocalDataSource.cachePokemonList(any()))
              .thenAnswer((_) async => null);
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
          when(() => mockRemoteDataSource.getPokemonList())
              .thenAnswer((_) async => pokemonMockList);
          when(() => mockLocalDataSource.cachePokemonList(any()))
              .thenAnswer((_) async => null);
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
          when(() => mockRemoteDataSource.getPokemonList())
              .thenThrow(ServerException());
          when(() => mockLocalDataSource.cachePokemonList(any()))
              .thenAnswer((_) async => null);
          // Act
          final result = await repository.getPokemonList();
          // assert
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test('should return last cached data when the cached data is present:',
          () async {
        // arrange
        when(() => mockLocalDataSource.getPokemonList())
            .thenAnswer((_) async => pokemonMockList);

        // act
        final result = await repository.getPokemonList();

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getPokemonList());
        expect(result, equals(Right(pokemonMockList)));
      });

      test('should return CacheFailure when there is not cached data present:',
          () async {
        // arrange
        when(() => mockLocalDataSource.getPokemonList())
            .thenThrow(CacheException());

        // act
        final result = await repository.getPokemonList();

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getPokemonList());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getPokemonByName', () {
    const pokemonName = "charmander";

    test('should check if the device is online', () async {
      // arrange
      when(() => mockRemoteDataSource.getPokemonByName(pokemonName))
          .thenAnswer((_) async => pokemonMock);
      when(() => mockLocalDataSource.cacheLastPokemonDetail(pokemonMock))
          .thenAnswer((_) async => null);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getPokemonByName(pokemonName);
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is success:',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemonByName(pokemonName))
              .thenAnswer((_) async => pokemonMock);
          when(() => mockLocalDataSource.cacheLastPokemonDetail(pokemonMock))
              .thenAnswer((_) async => null);
          // Act
          final result = await repository.getPokemonByName(pokemonName);
          // assert
          expect(result, equals(Right(pokemonMock)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is success:',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemonByName(pokemonName))
              .thenAnswer((_) async => pokemonMock);
          when(() => mockLocalDataSource.cacheLastPokemonDetail(pokemonMock))
              .thenAnswer((_) async => null);
          // Act
          await repository.getPokemonByName(pokemonName);
          // assert
          verify(() => mockLocalDataSource.cacheLastPokemonDetail(pokemonMock));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccess:',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemonByName(pokemonName))
              .thenThrow(ServerException());
          when(() => mockLocalDataSource.cachePokemonList(any()))
              .thenAnswer((_) async => null);
          // Act
          final result = await repository.getPokemonByName(pokemonName);
          // assert
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test('should return last cached data when the cached data is present:',
          () async {
        // arrange
        when(() => mockLocalDataSource.getPokemonByName(pokemonName))
            .thenAnswer((_) async => pokemonMock);

        // act
        final result = await repository.getPokemonByName(pokemonName);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getPokemonByName(pokemonName));
        expect(result, equals(Right(pokemonMock)));
      });

      test('should return CacheFailure when there is not cached data present:',
          () async {
        // arrange
        when(() => mockLocalDataSource.getPokemonByName(pokemonName))
            .thenThrow(CacheException());

        // act
        final result = await repository.getPokemonByName(pokemonName);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getPokemonByName(pokemonName));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
