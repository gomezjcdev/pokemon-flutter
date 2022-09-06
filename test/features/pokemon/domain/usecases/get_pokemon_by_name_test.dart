import 'package:dartz/dartz.dart';
import 'package:flutter_pokemon/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:flutter_pokemon/features/pokemon/domain/usecases/get_pokemon_by_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/pokemons.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository mockPokemonRepository = MockPokemonRepository();
  late GetPokemonByName useCase = GetPokemonByName(mockPokemonRepository);

  test('should get pokemon list from repository', () async {
    // arrange
    const nameToFind = 'charmander';
    when(() => mockPokemonRepository.getPokemonByName(nameToFind))
        .thenAnswer((_) async => Right(pokemonMock));

    // act
    final result = await useCase(Params(nameToFind));

    // assert
    expect(result, Right(pokemonMock));
  });
}
