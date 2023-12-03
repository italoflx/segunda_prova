import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/anime.dart';
import 'package:segunda_prova/helpers/anime_helper.dart';

class TelaDetalhes extends StatelessWidget {
  final int id;

  const TelaDetalhes({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Anime'),
      ),
      body: FutureBuilder<Anime?>(
        future: AnimeHelper().getAnimeById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Nenhum dado encontrado'));
          } else {
            Anime anime = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${anime.id}'),
                  Text('Nome: ${anime.nome}'),
                  Text('Autor: ${anime.autor}'),
                  Text('Gênero: ${anime.genero}'),
                  Text('Classificação Indicativa: ${anime.classificacaoIndicativa}'),
                  Text('Estúdio: ${anime.estudio}'),
                  Text('Data de Exibição: ${anime.dataDeExibicao}'),
                  Text('Nota: ${anime.nota}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
