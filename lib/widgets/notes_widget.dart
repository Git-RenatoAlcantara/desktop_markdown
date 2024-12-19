import 'package:desktop_markdown/models/note.dart';
import 'package:desktop_markdown/models/note_data.dart';
import 'package:desktop_markdown/services/note_service.dart';
import 'package:desktop_markdown/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  QuillController _controller = QuillController.basic();
  NoteServices noteServices = NoteServices();
  Box? box;

  @override
  void initState() {
    super.initState();
    //Provider.of<NoteData>(context, listen: false).initializedNotes();
  }

  // add new note
  void addNewNote(int id) {
    // get text from editor
    String text = _controller.document.toPlainText();
    // add the new note
    //Provider.of<NoteData>(context, listen: false).addNewNote(Note(id: id, text: text));
  }

  void saveUpdateNote(Note note) {
    // get text from editor
    String text = _controller.document.toPlainText();
    //Provider.of<NoteData>(context, listen: false).updateNote(note, text);
  }

  void updateNote(Note note) {
    // update note
    //final doc = Document()..insert(0, note.text);
    setState(() {
      //_controller = QuillController( document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  // create a new note
  void createNewNote() {
    // create new id
    //int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    // create a blank note
    //Note newNote = Note(id: id, text: '');

    // go to edit the note
    //addDialog(newNote, true);
  }

// delete note
  void deleteNote(Note note) {
    //Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              onPressed: () => createNewNote(),
              elevation: 0,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: const Text('Vazio')));
  }

  // Notes Widget

  Widget notesWidget(value) {
    List<int> colors = [0xFFffb703, 0xFF023047, 0xFF2a9d8f];

    return value.getAllNotes().isEmpty
        ? const Center(
            child: Text(
            'Nothing here...',
            style: TextStyle(color: Colors.grey),
          ))
        : GridView.count(
            shrinkWrap: false,
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: List.generate(
              value.getAllNotes().length,
              (index) => Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Colors.grey.withOpacity(.3)),
                    color: Color(colors[index]).withOpacity(.5),
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: InkWell(
                  onTap: () => updateNote(value.getAllNotes()[index]),
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              value.getAllNotes()[index].text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
