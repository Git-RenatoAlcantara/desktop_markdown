import 'package:hive/hive.dart';

class NoteServices {
  Box? _noteBox;

  Future<void> openBox() async {
    _noteBox = await Hive.openBox('note_database');
  }

  Future<void> closeBox() async {
    await _noteBox!.close();
  }

  Future<void> addNote(List<dynamic> note) async {
    if (_noteBox == null) {
      await openBox();
    }

    print(note);
    await _noteBox!.add(note);
  }

  Future<List<dynamic>> getNotes() async {
    if (_noteBox == null) {
      await openBox();
    }

    return _noteBox!.values.toList();
  }

  Future<void> updateNote(int index, List<Map<String, dynamic>> note) async {
    if (_noteBox == null) {
      await openBox();
    }

    _noteBox!.putAt(index, note);
  }

  Future<void> deleteNote(int index) async {
    if (_noteBox == null) {
      await openBox();
    }

    List<dynamic> note = _noteBox!.getAt(index);

    _noteBox!.deleteAt(index);
  }

  Future<void> resetNotes() async {
    if (_noteBox == null) {
      await openBox();
    }

    _noteBox!.clear();
  }
}
