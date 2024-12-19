import 'package:flutter/cupertino.dart';

class PageData extends ChangeNotifier {
  late int currentPage = 0;
  late int currentIndexNode;
  List<dynamic> noteEdit = [];

  void setPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void setNoteEdit(int index, List<dynamic> note) {
    noteEdit = note;
    currentIndexNode = index;
    notifyListeners();
  }
}
