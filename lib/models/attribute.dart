class Attribute {
  bool? _bold;

  Attribute.fromJson(Map<String, dynamic> json) {
    _bold = json['bold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bold'] = _bold;
    return data;
  }
}