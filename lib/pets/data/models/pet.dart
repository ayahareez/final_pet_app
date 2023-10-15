class Pet {
  final String name, imageUrl;
  final String tips;
  final String id;
  bool isFav, isAdopted;

  Pet(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.tips,
      this.isFav = false,
      this.isAdopted = false});

  Map<String, dynamic> toMap() => {
        'name': name,
        'imageUrl': imageUrl,
        'tips': tips,
        'id': id,
        'isFav': isFav,
        'isAdopted': isAdopted
      };

  factory Pet.fromMap(Map<String, dynamic> map) => Pet(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      tips: map['tips'],
      isFav: map['isFav'],
      isAdopted: map['isAdopted']);
}