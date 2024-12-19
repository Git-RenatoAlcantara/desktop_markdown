import 'package:desktop_markdown/widgets/qill_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive/hive.dart';
import 'package:uuid_type/uuid_type.dart';

class NoteCreate extends StatefulWidget {
  const NoteCreate({super.key});

  @override
  State<NoteCreate> createState() => _NoteCreateState();
}

class _NoteCreateState extends State<NoteCreate> {
  final QuillController _controller = QuillController.basic();
  final box = Hive.box('note_database');
  final uid = TimeUuidGenerator().generate();

  @override
  void initState() {
    super.initState();
  }

  void _loadDocument() {
    List<dynamic> jsonNotes = box.get('notes');
    _controller.document = Document.fromJson(jsonNotes);
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: QillWidget(
      isEdit: false,
    ));
  }
}
