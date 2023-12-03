import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/anime.dart';
import 'package:segunda_prova/helpers/anime_helper.dart';
import 'package:segunda_prova/widgets/custom_form_field.dart';
import 'package:segunda_prova/widgets/custom_rating_bar.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Meus Animes"),
      ),
      body: const SingleChildScrollView(
        child: FormAnimeBody(),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class FormAnimeBody extends StatefulWidget {
  const FormAnimeBody({
    Key? key,
  });

  @override
  State<FormAnimeBody> createState() => _FormAnimeBodyState();
}

class _FormAnimeBodyState extends State<FormAnimeBody> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final autorController = TextEditingController();
  final generoController = TextEditingController();
  final classificacaoIndicativaController = TextEditingController();
  final estudioController = TextEditingController();
  final dataDeExibicaoController = TextEditingController();
  double nota = 0.0;

  final animeHelper = AnimeHelper(); // Usa a classe AnimeHelper

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Cadastro de Animes",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            CustomFormField(
              controller: nomeController,
              labelText: "Nome",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione um nome';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: autorController,
              labelText: "Autor",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione um autor';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: generoController,
              labelText: "Gênero",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione um gênero';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: classificacaoIndicativaController,
              labelText: "Classificação Indicativa",
              keyboard_type: TextInputType.number,
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione uma classificação indicativa';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: estudioController,
              labelText: "Estúdio",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione um estúdio';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: dataDeExibicaoController,
              labelText: "Data de Exibição",
              keyboard_type: TextInputType.number,
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione uma data de exibição';
                }
                return null;
              },
            ),
            CustomRatingBar(
              ratingFunction: (value) {
                nota = value;
              },
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Anime novoAnime = Anime(
                    nome: nomeController.text,
                    autor: autorController.text,
                    genero: generoController.text,
                    classificacaoIndicativa:
                        classificacaoIndicativaController.text,
                    estudio: estudioController.text,
                    dataDeExibicao: int.parse(dataDeExibicaoController.text),
                    nota: nota,
                  );

                  animeHelper.saveAnime(novoAnime);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cadastro realizado com sucesso!'),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Cadastrar",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
