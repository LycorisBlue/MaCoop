import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuloss_coo/models/Formation.dart';

import 'Admin.dart';
import 'Cooperative.dart';
import 'Membres.dart';


class DatabaseHelper {
  static final _databaseName = "MaCoop.db";
  static final _databaseVersion = 1;
  static final table1 = 'membres';
  static final table2 = 'admins';
  static final table3 = 'formations';
  static final table4 = 'formationParticipant';
  static final table5 = 'cooperatives';


  static final membreTable1 = {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'id_cooperative': 'TEXT',
    'id_section': 'TEXT',
    'id_type': 'TEXT',
    'nom': 'TEXT',
    'prenom': 'TEXT',
    'picture': 'TEXT',
    'dateOfbirth': 'TEXT',
    'telephone': 'TEXT',
    'adresse': 'TEXT',
    'email': 'TEXT'
  };

  static final membreTable2 = {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'nom': 'TEXT',
    'prenom': 'TEXT',
    'dateOfbirth': 'TEXT',
    'telephone': 'TEXT',
    'adresse': 'TEXT',
    'email': 'TEXT',
    'password': 'TEXT'
  };

  static final membreTable3 = {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'titre': 'TEXT',
    'formateur': 'TEXT',
    'description': 'TEXT',
    'datePrevu': 'TEXT',
    'lieu': 'TEXT',
    'id_cooperative': 'TEXT',
    'sections': 'TEXT',
  };

  static final membreTable4 = {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'formationId': 'TEXT',
    'participantId': 'TEXT',
    'participantNom': 'TEXT',
  };

  static final membreTable5 = {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'nom': 'TEXT',
    'president': 'TEXT',
    'adg': 'TEXT',
    'localisation': 'TEXT',
    'telephone': 'TEXT',
    'dateCreation': 'TEXT',  // Stocker comme texte ISO-8601
    'imagePath': 'TEXT',
    'sections': 'TEXT',  // JSON encoded list of sections
  };

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    final columns1 = membreTable1.entries.map((entry) => '${entry.key} ${entry.value}').join(', ');
    final columns2 = membreTable2.entries.map((entry) => '${entry.key} ${entry.value}').join(', ');
    final columns3 = membreTable3.entries.map((entry) => '${entry.key} ${entry.value}').join(', ');
    final columns4 = membreTable4.entries.map((entry) => '${entry.key} ${entry.value}').join(', ');
    final columns5 = membreTable5.entries.map((entry) => '${entry.key} ${entry.value}').join(', ');

    await db.execute('''
      CREATE TABLE $table1 (
        $columns1
      )
    ''');
    await db.execute('''
      CREATE TABLE $table2 (
        $columns2
      )
    ''');
    await db.execute('''
      CREATE TABLE $table3 (
        $columns3
      )
    ''');
    await db.execute('''
      CREATE TABLE $table4 (
        $columns4
      )
    ''');
    await db.execute('''
      CREATE TABLE $table5 (
        $columns5
      )
    ''');
  }

  Future<int> insertMember(Membre membre) async {
    Database db = await database;
    int id = await db.insert(table1, membre.toMap());
    return id;
  }

  Future<int> insertAdmin(Admin admin) async {
    Database db = await database;
    int id = await db.insert(table2, admin.toMap());
    return id;
  }

  Future<int> insertFormation(Formation formation) async {
    Database db = await database;
    int id = await db.insert(table3, formation.toMap());
    return id;
  }

  Future<int> insertCooperative(Cooperative cooperative) async {
    Database db = await database;  // Assurez-vous que `database` est l'instance correctement initialisée de votre base de données.
    int id = await db.insert(table5, cooperative.toMap());  // Utilisez `table5` qui est le nom de votre table dans la base de données.
    return id;
  }





  Future<List<Membre>> membres() async {
    Database db = await database;
    List<Map> maps = await db.query(table1);

    return List.generate(maps.length, (i) {
      return Membre(
        id: maps[i]['id'],
        idCooperative: maps[i]['id_cooperative'],
        idSection: maps[i]['id_section'],
        idType: maps[i]['id_type'],
        nom: maps[i]['nom'],
        prenom: maps[i]['prenom'],
        picture: maps[i]['picture'],
        dateOfbirth: maps[i]['dateOfbirth'],
        telephone: maps[i]['telephone'],
        adresse: maps[i]['adresse'],
        email: maps[i]['email'],
      );
    });
  }

  // Fonction pour récupérer les membres par liste de sections
  Future<List<Membre>> getMembersBySections(List<String> sections) async {
    Database db = await database; // Assurez-vous que c'est l'instance correctement initialisée de votre base de données
    // Construction de la clause WHERE pour filtrer par sections
    String whereClause = "id_section IN (${List.filled(sections.length, '?').join(', ')})";
    // Récupération des membres correspondant aux sections
    final List<Map<String, dynamic>> maps = await db.query(
        table1,
        where: whereClause,
        whereArgs: sections
    );

    // Conversion des résultats en une liste de Membres utilisant List.generate
    return List.generate(maps.length, (i) {
      return Membre(
        id: maps[i]['id'],
        idCooperative: maps[i]['id_cooperative'],
        idSection: maps[i]['id_section'],
        idType: maps[i]['id_type'],
        nom: maps[i]['nom'],
        prenom: maps[i]['prenom'],
        picture: maps[i]['picture'],
        dateOfbirth: maps[i]['dateOfbirth'],
        telephone: maps[i]['telephone'],
        adresse: maps[i]['adresse'],
        email: maps[i]['email'],
      );
    });
  }



  Future<List<Admin>> admins() async {
    Database db = await database;
    List<Map> maps = await db.query(table2);

    return List.generate(maps.length, (i) {
      return Admin(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        prenom: maps[i]['prenom'],
        dateOfbirth: maps[i]['dateOfbirth'],
        telephone: maps[i]['telephone'],
        adresse: maps[i]['adresse'],
        email: maps[i]['email'],
        password: maps[i]['password']
      );
    });
  }

  Future<List<Cooperative>> cooperatives() async {
    Database db = await database; // S'assurer que c'est l'instance correctement initialisée de votre base de données
    final List<Map<String, dynamic>> maps = await db.query('cooperatives'); // Utiliser le nom réel de la table

    return List.generate(maps.length, (i) {
      return Cooperative(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        president: maps[i]['president'],
        adg: maps[i]['adg'],
        localisation: maps[i]['localisation'],
        telephone: maps[i]['telephone'],
        dateCreation: DateTime.parse(maps[i]['dateCreation']),
        imagePath: maps[i]['imagePath'],
        sections: List<String>.from(json.decode(maps[i]['sections'])),  // Assumer que 'sections' est stocké sous forme de JSON string
      );
    });
  }

  Future<List<Formation>> formations() async {
    Database db = await database; // Assurez-vous d'avoir une instance de la base de données initialisée
    final List<Map<String, dynamic>> maps = await db.query('formations'); // Utilisez le nom réel de votre table

    return List.generate(maps.length, (i) {
      return Formation(
        id: maps[i]['id'] as int?,
        titre: maps[i]['titre'] as String,
        formateur: maps[i]['formateur'] as String,
        description: maps[i]['description'] as String,
        datePrevu: DateTime.parse(maps[i]['datePrevu'] as String),
        lieu: maps[i]['lieu'] as String,
        idCooperative: maps[i]['id_cooperative'] as String,  // Assurez-vous que la clé correspond à celle de votre DB
        sections: List<String>.from(json.decode(maps[i]['sections'] as String)),
      );
    });
  }



  Future<List> connexion(String email, String password) async {
    final Database db = await database; // Assurez-vous que `database` est correctement initialisé et accessible
    // Recherche de l'utilisateur par email
    final List<Map<String, dynamic>> users = await db.query(
      table2, // Assurez-vous d'utiliser le nom correct de votre table
      where: 'email = ?',
      whereArgs: [email],
    );

    if (users.isEmpty) {
      return ["email not found"];
    } else {
      final user = Admin.fromMap(users.first); // Convertit le premier résultat en un objet Membre2
      // Vérification du mot de passe
      if (user.password == password) {
        return ["success", user.nom, user.email];
      } else {
        return ["password not correspond with email ${user.password}"];
      }
    }
  }

}
