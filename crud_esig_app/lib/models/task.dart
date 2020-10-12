class Task{
  int id;
  String description;
  bool done;

  Task({this.id, this.description, this.done});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['done'] = this.done;
    return data;
  }
}