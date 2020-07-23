class Breed {
  final String name;
  final String temperament;
  final String description;
  final String origin;
  final String lifeSpan;
  final String id;

  Breed(
      {this.name,
      this.temperament,
      this.description,
      this.origin,
      this.lifeSpan,
      this.id});

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
        name: json['name'],
        temperament: json['temperament'],
        description: json['description'],
        origin: json['origin'],
        lifeSpan: json['life_span'],
        id: json['id']);
  }
}
