class AttackModel {
  String? from;
  String? to;
  String? id;
  bool? color;
  List location = [];

  AttackModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    from = json["from"];
    to = json['to'];
    color = json["color"];
    location = json['location'];
  }


  Map<String, dynamic> toJson() =>
      {"id": id, "from": from, "to": to, 'location': location,"color":color};
}