class Pokemon {
  Pokemon({
    required this.abilities,
    required this.baseExperience,
    required this.forms,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastTypes,
    required this.species,
    required this.weight,
  });

  final List<Ability> abilities;
  final int baseExperience;
  final List<Species> forms;
  final List<GameIndex> gameIndices;
  final int height;
  final List<HeldItem> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Move> moves;
  final String name;
  final int order;
  final List<dynamic> pastTypes;
  final Species species;
  final int weight;
}

class Ability {
  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  Species ability;
  bool isHidden;
  int slot;
}

class Species {
  Species({
    required this.name,
    required this.url,
  });

  String name;
  String url;
}

class GameIndex {
  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  int gameIndex;
  Species version;
}

class HeldItem {
  HeldItem({
    required this.item,
    required this.versionDetails,
  });

  Species item;
  List<VersionDetail> versionDetails;
}

class VersionDetail {
  VersionDetail({
    required this.rarity,
    required this.version,
  });

  int rarity;
  Species version;
}

class Move {
  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  Species move;
  List<VersionGroupDetail> versionGroupDetails;
}

class VersionGroupDetail {
  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  int levelLearnedAt;
  Species moveLearnMethod;
  Species versionGroup;
}
