import 'dart:convert';

import 'package:flutter_pokemon/features/pokemon/data/models/pokemon_list_info_model.dart';
import 'package:flutter_pokemon/features/pokemon/domain/entities/pokemon_list_info.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const pokemonListModel = PokemonListInfoModel(
    id: 1,
    name: 'bulbasaur',
    imageUrl: 'https://pokeapi.co/api/v2/pokemon/1/',
  );

  test(
    'should be a subclass of PokemonListInfo entity',
    () {
      //assert
      expect(pokemonListModel, isA<PokemonListInfo>());
    },
  );

  test('should return a valid model when import from json', () {
    // arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('pokemon_list.json'));
    // act
    final result = PokemonListInfoModel.fromJson(jsonMap);
    // assert
    expect(result, pokemonListModel);
  });

  test('toJson should return a json map containing the proper data', () {
    // act
    final result = pokemonListModel.toJson();
    // assert
    final expectedMap = {
      "id": 1,
      "name": "bulbasaur",
      "imageUrl": "https://pokeapi.co/api/v2/pokemon/1/"
    };
    expect(result, expectedMap);
  });
}
