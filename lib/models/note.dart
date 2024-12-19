import 'package:flutter_quill/flutter_quill.dart';

class Note {
  String? _insert;
  Map<String, dynamic>? _attributes;

  Note(this._insert, [this._attributes]);

  factory Note.fromJson(dynamic json) {
    return Note(
        json['insert'] as String, json['attributes'] ?? { "bold" : false } as Map<String, dynamic> );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['insert'] = _insert;
    data['bold'] = _attributes;

    return data;
  }
}
