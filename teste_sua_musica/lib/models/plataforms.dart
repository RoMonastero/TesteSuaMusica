class Plataforms {
  final int id;
  final String name;

  Plataforms({required this.id, required this.name});

  Plataforms.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
