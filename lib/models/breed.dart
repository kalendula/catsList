class Breed {
  final String name;
  final String temperament;
  final String description;
  final String origin;
  final String lifeSpan;

  Breed(
      {this.name,
      this.temperament,
      this.description,
      this.origin,
      this.lifeSpan});

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      name: json['name'],
      temperament: json['temperament'],
      description: json['description'],
      origin: json['origin'],
      lifeSpan: json['life_span'],
    );
  }
}
