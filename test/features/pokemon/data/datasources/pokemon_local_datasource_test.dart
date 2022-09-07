import 'dart:convert';

import 'package:flutter_pokemon/features/pokemon/data/datasources/pokemon_local_datasource.dart';
import 'package:flutter_pokemon/features/pokemon/data/models/pokemon_list_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late PokemonLocalDatasourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = PokemonLocalDatasourceImpl(mockSharedPreferences);
  });

  group('getPokemonList', () {
    final pokemonModel =
        PokemonListInfoModel.fromJson(jsonDecode(fixture('pokemon_list.json')));
    // arrange
    test(
        'should return PokemonList from SharedPreferences when there is in the cache',
        () async {
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture('pokemon_list.json'));
      // act
      final result = await dataSource.getPokemonList();
      // assert
      verify(() => mockSharedPreferences.getString('CACHE_POKEMON_LIST'));
      expect(result, equals(pokemonModel));
    });
  });
}
