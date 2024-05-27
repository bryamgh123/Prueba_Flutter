import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operation {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'notes.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, fecha TEXT, detalle TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insert(BuildContext context, Note note) async {
    Database database = await _openDB();
    int result = await database.insert("notes", note.toMap());
    // Notificar que los datos han cambiado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nota guardada correctamente'),
      ),
    );
    return result;
  }

  static Future<int> update(BuildContext context, Note note) async {
    Database database = await _openDB();
    int result = await database
        .update("notes", note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    // Notificar que los datos han cambiado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nota actualizada correctamente'),
      ),
    );
    return result;
  }

  static Future<int> delete(BuildContext context, Note note) async {
    Database database = await _openDB();
    int result =
        await database.delete("notes", where: 'id = ?', whereArgs: [note.id]);
    // Notificar que los datos han cambiado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nota eliminada correctamente'),
      ),
    );
    return result;
  }

  static Future<List<Note>> notes() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> notesMap = await database.query("notes");
    List<Note> notesList = [];
    for (var n in notesMap) {
      notesList.add(
        Note(
          id: n['id'],
          title: n['title'],
          fecha: n['fecha'],
          detalle: n['detalle'],
        ),
      );
    }
    return notesList;
  }
}
