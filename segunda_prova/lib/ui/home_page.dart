import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/anime.dart';
import 'package:segunda_prova/helpers/anime_helper.dart';
import 'package:segunda_prova/ui/cadastro_page.dart';
import 'package:segunda_prova/ui/tela_altera_page.dart';
import 'package:segunda_prova/ui/tela_detalhe_page.dart';
import 'package:segunda_prova/ui/tela_sobre_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Anime>> animes;

  @override
  void initState() {
    super.initState();
    refreshAnimeList();
  }

  void refreshAnimeList() {
    setState(() {
      animes = AnimeHelper().getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Animes"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TelaSobre(),
                ),
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: FutureBuilder<List<Anime>>(
        future: animes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListItem(anime: snapshot.data![index]);
              },
            );
          }
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastroPage(),
            ),
          );
          refreshAnimeList(); // Atualiza a lista após o cadastro
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}


class ListBody extends StatefulWidget {
  const ListBody({Key? key});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  final animeHelper = AnimeHelper(); // Usa a classe AnimeHelper
  late Future<List> animes;

  @override
  void initState() {
    super.initState();
    animes = animeHelper.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: animes,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return ListItem(anime: snapshot.data![i]);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final Anime anime;

  const ListItem({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaDetalhes(id: anime.id),
          ),
        );
      },
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaAltera(id: anime.id),
          ),
        );
      },
      child: ListTile(
        title: Text(anime.nome),
        subtitle: Text(anime.autor),
      ),
    );
  }
}