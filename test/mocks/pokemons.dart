import 'package:flutter_pokemon/features/pokemon/domain/entities/pokemon.dart';
import 'package:flutter_pokemon/features/pokemon/domain/entities/pokemon_list_info.dart';

final pokemonMockList = [
  const PokemonListInfo(id: 1, name: 'Test1', imageUrl: 'https://image1.com'),
  const PokemonListInfo(id: 2, name: 'Test2', imageUrl: 'https://image2.com'),
  const PokemonListInfo(id: 3, name: 'Test3', imageUrl: 'https://image3.com')
];

final pokemonMock = Pokemon(
  abilities: [
    Ability(
        ability: Species(
            name: "Blaze", url: "https://pokeapi.co/api/v2/ability/66/"),
        isHidden: false,
        slot: 1)
  ],
  baseExperience: 62,
  forms: [
    Species(
        name: "charmander", url: "https://pokeapi.co/api/v2/pokemon-form/4/")
  ],
  gameIndices: [
    GameIndex(
        gameIndex: 176,
        version:
        Species(name: "red", url: "https://pokeapi.co/api/v2/version/1/"))
  ],
  height: 6,
  heldItems: [],
  id: 4,
  isDefault: true,
  locationAreaEncounters: "https://pokeapi.co/api/v2/pokemon/4/encounters",
  moves: [
    Move(
      move:
      Species(name: "mega-punch", url: "https://pokeapi.co/api/v2/move/5/"),
      versionGroupDetails: [
        VersionGroupDetail(
          levelLearnedAt: 0,
          moveLearnMethod: Species(
              name: "machine",
              url: "https://pokeapi.co/api/v2/move-learn-method/4/"),
          versionGroup: Species(
              name: "red-blue",
              url: "https://pokeapi.co/api/v2/version-group/1/"),
        )
      ],
    )
  ],
  name: "charmander",
  order: 5,
  pastTypes: [],
  species: Species(
      name: "charmander", url: "https://pokeapi.co/api/v2/pokemon-species/4/"),
  weight: 85,
);
