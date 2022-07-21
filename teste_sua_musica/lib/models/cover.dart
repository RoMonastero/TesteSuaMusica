class Cover {
  final int id;
  final String url;

  Cover({
    required this.id,
    required this.url,
  });

  Cover.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'] ?? '';
}
