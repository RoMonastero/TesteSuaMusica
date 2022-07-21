class Plataform {
  final int id;
  final String name;

  Plataform({required this.id, required this.name});

  Plataform.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
