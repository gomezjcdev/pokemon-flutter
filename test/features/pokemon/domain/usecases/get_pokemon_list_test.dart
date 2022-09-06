import 'package:dartz/dartz.dart';
import 'package:flutter_pokemon/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:flutter_pokemon/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/pokemons.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository mockPokemonRepository = MockPokemonRepository();
  late GetPokemonList useCase = GetPokemonList(mockPokemonRepository);

  test('should get pokemon list from repository', () async {
    // arrange
    when(() => mockPokemonRepository.getPokemonList()).thenAnswer((_) async => Right(pokemonMockList));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Right(pokemonMockList));
  });
}