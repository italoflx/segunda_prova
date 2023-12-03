//import 'package:flutter_database_app/domain/anime.dart';  // Importa a classe Anime

//import 'package:flutter_database_app/domain/livro.dart';
import 'package:path/path.dart';
import 'package:segunda_prova/domain/anime.dart';
import 'package:sqflite/sqflite.dart';

class AnimeHelper {
  // Singleton
  // Construtor interno
  static final AnimeHelper _instance = AnimeHelper.internal();

  // Criação do factory para retornar a instância
  factory AnimeHelper() => _instance;

  // AnimeHelper.instance
  AnimeHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    if (databasesPath == null) databasesPath = "";
    String path = join(databasesPath, "animes.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE ${Anime.animeTable}(${Anime.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "                                 ${Anime.nomeColumn} TEXT, "
          "                                 ${Anime.autorColumn} TEXT, "
          "                                 ${Anime.generoColumn} TEXT, "
          "                                 ${Anime.classificacaoIndicativaColumn} TEXT, "
          "                                 ${Anime.estudioColumn} TEXT, "
          "                                 ${Anime.dataDeExibicaoColumn} INTEGER, "
          "                                 ${Anime.notaColumn} REAL) ");
    });
  }

  Future<Anime> saveAnime(Anime a) async {
    Database? dbAnime = await db;
    if (dbAnime != null) {
      a.id = await dbAnime.insert(Anime.animeTable, a.toMap());
    }
    return a;
  }

  Future<Anime?> getAnimeById(int id) async {
    Database? dbAnime = await db;
    if (dbAnime != null) {
      List<Map> maps = await dbAnime.query(Anime.animeTable,
          columns: [
            Anime.idColumn,
            Anime.nomeColumn,
            Anime.autorColumn,
            Anime.generoColumn,
            Anime.classificacaoIndicativaColumn,
            Anime.estudioColumn,
            Anime.dataDeExibicaoColumn,
            Anime.notaColumn
          ],
          where: "${Anime.idColumn} = ?",
          whereArgs: [id]);
      if (maps.length > 0)
        return Anime.fromMap(maps.first);
      else
        return null;
    }
    return null;
  }

  Future<int> deleteAnime(int id) async {
    Database? dbAnime = await db;
    if (dbAnime != null) {
      return await dbAnime.delete(Anime.animeTable,
          where: "${Anime.idColumn} = ?", whereArgs: [id]);
    } else
      return 0;
  }

  Future<int> updateAnime(Anime a) async {
    Database? dbAnime = await db;
    if (dbAnime != null) {
      return await dbAnime.update(Anime.animeTable, a.toMap(),
          where: "${Anime.idColumn} = ?", whereArgs: [a.id]);
    } else {
      return 0;
    }
  }

  Future<List<Anime>> getAll() async {
  Database? dbAnime = await db;
  if (dbAnime != null) {
    List<Map<String, dynamic>> listMap = await dbAnime.query(Anime.animeTable);
    List<Anime> listAnimes = listMap.map((m) => Anime.fromMap(m)).toList();
    return listAnimes;
  } else {
    return [];
  }
}
}
