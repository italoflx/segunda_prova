class Anime {
  static const String animeTable = "anime_table";
  static const String idColumn = "id";
  static const String nomeColumn = "nome";
  static const String autorColumn = "autor";
  static const String generoColumn = "genero";
  static const String classificacaoIndicativaColumn = "classificacao_indicativa";
  static const String estudioColumn = "estudio";
  static const String dataDeExibicaoColumn = "data_de_exibicao";
  static const String notaColumn = "nota";

  int id = 0;
  String nome = '';
  String autor = '';
  String genero = '';
  String classificacaoIndicativa = '';
  String estudio = '';
  int dataDeExibicao = 0;
  double nota = 0.0;

  Anime({
    this.id = 0,
    required this.nome,
    required this.autor,
    required this.genero,
    required this.classificacaoIndicativa,
    required this.estudio,
    required this.dataDeExibicao,
    required this.nota,
  });

  Anime.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    autor = map[autorColumn];
    genero = map[generoColumn];
    classificacaoIndicativa = map[classificacaoIndicativaColumn];
    estudio = map[estudioColumn];
    dataDeExibicao = map[dataDeExibicaoColumn];
    nota = map[notaColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      nomeColumn: nome,
      autorColumn: autor,
      generoColumn: genero,
      classificacaoIndicativaColumn: classificacaoIndicativa,
      estudioColumn: estudio,
      dataDeExibicaoColumn: dataDeExibicao,
      notaColumn: nota,
    };
  }

  @override
  String toString() {
    return 'Anime{id: $id, nome: $nome, autor: $autor, genero: $genero, classificacaoIndicativa: $classificacaoIndicativa, estudio: $estudio, dataDeExibicao: $dataDeExibicao, nota: $nota}';
  }
}
