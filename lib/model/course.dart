class Course {
  int _id, _hours;
  String _name, _content;
  Course(dynamic obj) {
    _id = obj["id"];
    _hours = obj["hours"];
    _name = obj["name"];
    _content = obj["content"];
  }

  Course.fromMap(Map<String, dynamic> data) {
    _id = data["id"];
    _hours = data["hours"];
    _name = data["name"];
    _content = data["content"];
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'content': _content,
        'hours': _hours,
      };

  int get id => _id;
  String get name => _name;
  String get content => _content;
  int get hours => _hours;
}
