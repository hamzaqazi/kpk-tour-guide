class Place {
  String name;
  String address;
  String description;
  List<String> images;

  Place({
    required this.name,
    required this.address,
    required this.description,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'images': images,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'],
      address: map['address'],
      description: map['description'],
      images: List<String>.from(map['images']),
    );
  }
}
