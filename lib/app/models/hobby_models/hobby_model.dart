class HobbyModel {
  String? id;
  String? name;

  HobbyModel({this.name, this.id});

  HobbyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
