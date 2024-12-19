import 'package:desktop_markdown/models/note.dart';
import 'package:desktop_markdown/models/page_data.dart';
import 'package:desktop_markdown/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class QillWidget extends StatefulWidget {
  final bool isEdit;
  const QillWidget({super.key, required this.isEdit});

  @override
  State<QillWidget> createState() => _QillWidgetState();
}

class _QillWidgetState extends State<QillWidget> {
  final QuillController _controller = QuillController.basic();
  List<Map<String, dynamic>> allNotes = [];
  NoteServices noteServices = NoteServices();
  bool editMode = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    List<dynamic> noteEdit =
        Provider.of<PageData>(context, listen: false).noteEdit;

    if (noteEdit.isNotEmpty && widget.isEdit) {
      _controller.document = Document.fromJson(noteEdit);
    }
    editMode = widget.isEdit == true ? true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.3)))),
                  child: QuillToolbar.simple(
                    configurations: QuillSimpleToolbarConfigurations(
                      controller: _controller,
                      showRedo: false,
                      showSmallButton: false,
                      showSubscript: false,
                      showLeftAlignment: false,
                      showJustifyAlignment: false,
                      showRightAlignment: false,
                      showSuperscript: false,
                      showUndo: false,
                      showAlignmentButtons: false,
                      showBackgroundColorButton: false,
                      showCenterAlignment: false,
                      showColorButton: false,
                      showCodeBlock: false,
                      showDirection: false,
                      showFontFamily: false,
                      showDividers: false,
                      showIndent: false,
                      showHeaderStyle: false,
                      showLink: false,
                      showSearchButton: false,
                      showInlineCode: false,
                      showQuote: false,
                      showListNumbers: false,
                      showListBullets: false,
                      showClearFormat: false,
                      showBoldButton: true,
                      showFontSize: false,
                      showItalicButton: true,
                      showUnderLineButton: true,
                      showStrikeThrough: false,
                      showListCheck: false,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('de'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: QuillEditor.basic(
                      focusNode: _focusNode,
                      configurations: QuillEditorConfigurations(
                        enableScribble: false,
                        showCursor: true,
                        floatingCursorDisabled: true,
                        padding: const EdgeInsets.all(25),
                        controller: _controller,
                        readOnly: false,
                        autoFocus: false,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('de'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30.0,
          right: MediaQuery.of(context).size.width * .32,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Deletar Nota'),
          ),
        ),
      ],
    );
  }

  Padding editor(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0, color: Colors.grey.withOpacity(0.3)))),
              child: QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: _controller,
                  showRedo: false,
                  showSmallButton: false,
                  showSubscript: false,
                  showLeftAlignment: false,
                  showJustifyAlignment: false,
                  showRightAlignment: false,
                  showSuperscript: false,
                  showUndo: false,
                  showAlignmentButtons: false,
                  showBackgroundColorButton: false,
                  showCenterAlignment: false,
                  showColorButton: false,
                  showCodeBlock: false,
                  showDirection: false,
                  showFontFamily: false,
                  showDividers: false,
                  showIndent: false,
                  showHeaderStyle: false,
                  showLink: false,
                  showSearchButton: false,
                  showInlineCode: false,
                  showQuote: false,
                  showListNumbers: false,
                  showListBullets: false,
                  showClearFormat: false,
                  showBoldButton: true,
                  showFontSize: false,
                  showItalicButton: true,
                  showUnderLineButton: true,
                  showStrikeThrough: false,
                  showListCheck: false,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('de'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: QuillEditor.basic(
                  focusNode: _focusNode,
                  configurations: QuillEditorConfigurations(
                    enableScribble: false,
                    showCursor: true,
                    floatingCursorDisabled: true,
                    padding: const EdgeInsets.all(25),
                    controller: _controller,
                    readOnly: false,
                    autoFocus: false,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('de'),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (widget.isEdit) {
                    List<Map<String, dynamic>> note =
                        _controller.document.toDelta().toJson();

                    noteServices.updateNote(
                        Provider.of<PageData>(context, listen: false)
                            .currentIndexNode,
                        note);

                    //box.clear();
                    //print(_box);
                  } else {
                    List<Map<String, dynamic>> note =
                        _controller.document.toDelta().toJson();
                    //NoteList noteList = NoteList(note);
                    for (var i = 0; i < note.length; i++) {
                      allNotes.add(Note.fromJson(note[i]).toJson());
                    }
                    noteServices.addNote(allNotes);

                    Provider.of<PageData>(context, listen: false).setPage(1);
                  }
                },
                child: const Text('Salvar nota')),
            TextButton(
                onPressed: () {
                  noteServices.deleteNote(
                      Provider.of<PageData>(context, listen: false)
                          .currentIndexNode);
                },
                child: const Text('Deletar')),
          ],
        ),
      ),
    );
  }
}
