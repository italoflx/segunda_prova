import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/anime.dart';
import 'package:segunda_prova/helpers/anime_helper.dart';
import 'package:segunda_prova/ui/home_page.dart';

class TelaAltera extends StatefulWidget {
  final int id;

  const TelaAltera({Key? key, required this.id}) : super(key: key);

  @override
  _TelaAlteraState createState() => _TelaAlteraState();
}

class _TelaAlteraState extends State<TelaAltera> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _classificacaoIndicativaController =
      TextEditingController();
  final TextEditingController _estudioController = TextEditingController();
  final TextEditingController _dataDeExibicaoController =
      TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  final AnimeHelper _animeHelper = AnimeHelper();

  Future<Anime?> _loadData(int id) async {
    Anime? anime = await _animeHelper.getAnimeById(id);
    return anime;
  }

  @override
  void initState() {
    super.initState();
    _loadData(widget.id).then((anime) {
      if (anime != null) {
        _nomeController.text = anime.nome;
        _autorController.text = anime.autor;
        _generoController.text = anime.genero;
        _classificacaoIndicativaController.text = anime.classificacaoIndicativa;
        _estudioController.text = anime.estudio;
        _dataDeExibicaoController.text = anime.dataDeExibicao.toString();
        _notaController.text = anime.nota.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anime'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do anime.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _autorController,
                  decoration: const InputDecoration(labelText: 'Autor'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o autor do anime.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _generoController,
                  decoration: const InputDecoration(labelText: 'Gênero'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o gênero do anime.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _classificacaoIndicativaController,
                  decoration: const InputDecoration(
                      labelText: 'Classificação Indicativa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a classificação indicativa do anime.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _estudioController,
                  decoration: const InputDecoration(labelText: 'Estúdio'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o estúdio do anime.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dataDeExibicaoController,
                  decoration:
                      const InputDecoration(labelText: 'Data de Exibição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data de exibição do anime.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.datetime,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Atualizar o anime no banco de dados
                      await _animeHelper.updateAnime(
                        Anime(
                          id: widget.id,
                          nome: _nomeController.text,
                          autor: _autorController.text,
                          genero: _generoController.text,
                          classificacaoIndicativa:
                              _classificacaoIndicativaController.text,
                          estudio: _estudioController.text,
                          dataDeExibicao:
                              int.parse(_dataDeExibicaoController.text),
                          nota: double.parse(_notaController.text),
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Alteração realizada com sucesso!'),
                        ),
                      );

                      //Navigator.popUntil(context, ModalRoute.withName('/'));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
