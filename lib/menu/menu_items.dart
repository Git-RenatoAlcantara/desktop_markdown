import 'package:desktop_markdown/menu/menu_details.dart';
import 'package:desktop_markdown/menu/pages/dashboard_page.dart';
import 'package:desktop_markdown/menu/pages/note_create_page.dart';
import 'package:desktop_markdown/menu/pages/note_editing_page.dart';
import 'package:desktop_markdown/menu/pages/notes_page.dart';
import 'package:flutter/material.dart';

class MenuItems {
  List<MenuDetails> items = [
    MenuDetails(
        title: "Tela Inicial", icon: Icons.home, page: const DashboardPage()),
    MenuDetails(
        title: "Lista de Notas", icon: Icons.note, page: const NotesPage()),
    MenuDetails(
        title: "Editar Nota", icon: Icons.edit, page: const NoteEditing()),
    MenuDetails(
        title: "Criar Nota", icon: Icons.access_alarm, page: const NoteCreate())
  ];
}
