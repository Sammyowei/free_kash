import 'package:firebase_database/firebase_database.dart';
import 'package:free_kash/data/db/_db.dart';

/// A class for configuring database interactions with Firebase Realtime Database.
class DbConfig extends DB {
  /// The name of the database store (e.g., collection/table) to interact with.
  final String dbStore;

  set dbStore(String store) {
    dbStore = store;
  }

  String get store => dbStore;

  /// Instance of the Firebase Realtime Database.
  final _instance = FirebaseDatabase.instance;

  /// Constructor for [DbConfig].
  /// [dbStore] specifies the name of the database store.
  DbConfig({required this.dbStore});

  @override

  /// Creates a new entry in the database.
  /// [data]: The data to be stored in the database.
  /// [path]: The path at which the data should be stored.
  Future<void> create(data, String path) async {
    final db = _instance.databaseURL =
        'https://free-kash-default-rtdb.europe-west1.firebasedatabase.app';

    print(_instance.databaseURL);
    final dbPath = '$dbStore/$path';
    print(data);
    final ref = _instance.refFromURL("$db/$dbPath");
    return await ref.set(data);
  }

  @override

  /// Deletes an entry from the database.
  /// [identifier]: The identifier of the entry to be deleted.
  Future<void> delete(identifier) async {
    final dbPath = '$dbStore/$identifier';
    final ref = _instance.ref(dbPath);
    return await ref.remove();
  }

  @override

  /// Reads data from the database.
  /// [identifier]: The identifier of the data to be read.
  Future<DataSnapshot> read(identifier) async {
    final dbPath = '$dbStore/$identifier';
    final ref = _instance.ref(dbPath);
    return await ref.get();
  }

  @override

  /// Updates an existing entry in the database.
  /// [data]: The updated data.
  /// [identifier]: The identifier of the entry to be updated.
  Future<void> update(data, identifier) async {
    final dbPath = '$dbStore/$identifier';
    final ref = _instance.ref(dbPath);
    return await ref.update(data);
  }
}
