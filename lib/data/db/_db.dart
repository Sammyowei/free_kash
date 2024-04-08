import 'package:firebase_database/firebase_database.dart';

abstract class DB {
  Future<void> create(dynamic data, String path);

  Future<DatabaseEvent> read(dynamic identifier);

  Future<void> update(dynamic data, dynamic identifier);

  Future<void> delete(dynamic identifier);
}
