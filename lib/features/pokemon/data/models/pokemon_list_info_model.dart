import 'package:flutter_pokemon/features/pokemon/domain/entities/pokemon_list_info.dart';

class PokemonListInfoModel extends PokemonListInfo {
  const PokemonListInfoModel({required super.id, required super.name, required super.imageUrl});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory PokemonListInfoModel.fromJson(Map<String, dynamic> map) {
    final url = map["url"].toString();
    final urlSplit = url.split('/');
    urlSplit.removeLast();
    return PokemonListInfoModel(
      id: int.parse(urlSplit.last),
      name: map['name'] as String,
      imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${urlSplit.last}.png",
    );
  }
}