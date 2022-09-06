import 'package:equatable/equatable.dart';

class PokemonListInfo extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const PokemonListInfo({required this.id, required this.name, required this.imageUrl});

  @override
  List<Object> get props => [id, name];
}