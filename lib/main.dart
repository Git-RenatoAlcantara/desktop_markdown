import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_markdown/menu/menu_items.dart';
import 'package:desktop_markdown/models/note_data.dart';
import 'package:desktop_markdown/models/page_data.dart';
import 'package:desktop_markdown/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';


void main() async {
  // initialize hive
  await Hive.initFlutter();

  // open a hive box
  await NoteServices().openBox();
  
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Flutter Note";
    appWindow.show();
  });
}

const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteData(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
            backgroundColor: Colors.grey[200],
            body: WindowBorder(
              color: Colors.grey,
              width: 1,
              child: const Row(
                children: [
                  LeftSide(),
                  SizedBox(
                    width: 5,
                  ),
                  RightSide()
                ],
              ),
            )),
      ),
    );
  }
}

const sidebarColor = Color(0xFFF6A00C);

class LeftSide extends StatefulWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  final controller = MenuItems();

  bool selectedItem = false;

  void updatePage(int page) {
    Provider.of<PageData>(context, listen: false).setPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final int currentPage =
        Provider.of<PageData>(context, listen: true).currentPage;

    return Expanded(
        flex: 2,
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                WindowTitleBarBox(child: MoveWindow()),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .4,
                  child: ListView.builder(
                    itemCount: controller.items.length - 2,
                    itemBuilder: (context, index) {
                      selectedItem = currentPage == index;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedItem
                                ? Colors.green.withOpacity(.05)
                                : Colors.transparent),
                        child: ListTile(
                          title: Text(controller.items[index].title),
                          leading: Icon(controller.items[index].icon),
                          onTap: () {
                            updatePage(index);
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            )));
  }
}

const backgroundStartColor = Color(0xFFFFD500);
const backgroundEndColor = Color(0xFFF6A00C);

class RightSide extends StatefulWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  final controller = MenuItems();

  @override
  Widget build(BuildContext context) {
    final int currentPage =
        Provider.of<PageData>(context, listen: true).currentPage;

    return Expanded(
        flex: 7,
        child: SizedBox(
          child: Container(
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              WindowTitleBarBox(
                child: Row(
                  children: [
                    Expanded(child: MoveWindow()),
                    const WindowButtons()
                  ],
                ),
              ),

              // NotesView
              //Pages
              Expanded(
                  child: PageView.builder(
                      itemCount: controller.items.length,
                      onPageChanged: (value) {
                        Provider.of<PageData>(context, listen: false)
                            .setPage(value);
                      },
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: controller.items[currentPage].page,
                        );
                      }))
            ]),
          ),
        ));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
