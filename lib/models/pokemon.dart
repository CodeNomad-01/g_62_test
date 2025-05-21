class Pokemon {
  final String name;
  final String url;
  final int? id;
  final int? height;
  final int? weight;
  final String? type;
  final String? imageUrl;

  Pokemon({
    required this.name,
    required this.url,
    this.id,
    this.height,
    this.weight,
    this.type,
    this.imageUrl,
  });

  factory Pokemon.fromListJson(Map<String, dynamic> json) {
    return Pokemon(name: json['name'], url: json['url']);
  }

  factory Pokemon.fromDetailJson(
    Map<String, dynamic> json,
    String name,
    String url,
  ) {
    return Pokemon(
      name: name,
      url: url,
      id: json['id'],
      height: json['height'],
      weight: json['weight'],
      type:
          json['types'] != null && json['types'].isNotEmpty
              ? json['types'][0]['type']['name']
              : null,
      imageUrl:
          json['sprites'] != null ? json['sprites']['front_default'] : null,
    );
  }
}
