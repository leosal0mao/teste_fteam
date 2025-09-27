import 'package:flutter/material.dart';
import 'package:teste_fteam/domain/entities/character.dart';
import 'package:teste_fteam/presentation/pages/character_detail_page.dart';

class CustomListTile extends StatelessWidget {
  final String image;
  final String name;
  final String species;
  final Character character;

  const CustomListTile({
    super.key,
    required this.image,
    required this.name,
    required this.species,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(image)),
      title: Text(name),
      subtitle: Text(species),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailPage(character: character),
          ),
        );
      },
    );
  }
}
