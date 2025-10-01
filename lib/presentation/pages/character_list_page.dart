import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_fteam/presentation/widgets/custom_list_tile.dart';
import 'package:teste_fteam/presentation/widgets/custom_search_field.dart';
import '../providers/character_provider.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharacterProvider>(context, listen: false).fetchFirstPage();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    final provider = Provider.of<CharacterProvider>(context, listen: false);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      provider.fetchNextPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      Provider.of<CharacterProvider>(
        context,
        listen: false,
      ).fetchFirstPage(query: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty Characters')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchField(
              searchController: _searchController,
              onSearchChanged: _onSearchChanged,
              labelText: 'Search character',
              hintText: 'Example: Rick Sanchez, Morty Smith, etc.',
            ),
          ),
          Expanded(
            child: Consumer<CharacterProvider>(
              builder: (context, provider, child) {
                if (provider.state == ViewState.loading &&
                    provider.characters.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.state == ViewState.error &&
                    provider.characters.isEmpty) {
                  return Center(child: Text(provider.errorMessage));
                }
                if (provider.characters.isEmpty) {
                  return const Center(
                    child: Text('Nenhum personagem encontrado.'),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      provider.characters.length +
                      (provider.isLoadingNextPage ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == provider.characters.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final character = provider.characters[index];

                    return CustomListTile(
                      image: character.image,
                      name: character.name,
                      species: character.species,
                      character: character,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
