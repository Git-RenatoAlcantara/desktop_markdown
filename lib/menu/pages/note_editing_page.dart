import 'package:desktop_markdown/widgets/qill_widget.dart';
import 'package:flutter/cupertino.dart';

class NoteEditing extends StatelessWidget {
  const NoteEditing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: QillWidget(isEdit: true,)
    );
  }
}
