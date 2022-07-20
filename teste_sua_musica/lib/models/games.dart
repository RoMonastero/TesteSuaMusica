class Games {
  final int id;
  final String name;
  final String? summary;

  Games({
    required this.id,
    required this.name,
    this.summary,
  });

  Games.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        summary = json['summary'];
}
