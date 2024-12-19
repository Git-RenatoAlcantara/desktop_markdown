import 'package:desktop_markdown/models/page_data.dart';
import 'package:desktop_markdown/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late Box box;
  NoteServices noteServices = NoteServices();
  List<dynamic> _notes = [];
  final QuillController _controller = QuillController.basic();

  @override
  void initState() {
    //box.clear();
    _loadNotes();
    super.initState();
  }

  void initializeHive() {}

  Future _loadNotes() async {
    //await noteServices.resetNotes();
    _notes = await noteServices.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            "Notes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width * .9,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      blurRadius: 1,
                      spreadRadius: 1)
                ]),
            child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Procurar nota",
                    border: InputBorder.none,
                    icon: Icon(Icons.search))),
          ),
        ),
        SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () => {
                      Provider.of<PageData>(context, listen: false).setPage(3)
                    },
                    elevation: 0,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  body: ValueListenableBuilder<Box>(
                      valueListenable: Hive.box('note_database').listenable(),
                      builder: (context, box, Widget) {
                        _notes = box.values.toList();

                        return responsiveGrid(context);
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ResponsiveGridList responsiveGrid(BuildContext context) {
    return ResponsiveGridList(
      horizontalGridMargin: 30,
      verticalGridMargin: 10,
      minItemWidth: 200,
      children: List.generate(_notes.length, (index) {
        //List<Map<dynamic, dynamic>> allData  = getAll()[index].map((element) => element[index]).toList();
        _controller.document = Document.fromJson(_notes[index]);

        return Container(
          height: 250,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.8),
                  blurRadius: 1,
                  spreadRadius: 0.1)
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: InkWell(
            onTap: () => {
              Provider.of<PageData>(context, listen: false)
                  .setNoteEdit(index, _notes[index]),
                  
              Provider.of<PageData>(context, listen: false).setPage(2)
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(Document.fromJson(_notes[index]).toPlainText()),
              ),
            ),
          ),
        );
      }),
    );
  }
}
