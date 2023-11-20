class Place {
  String name;
  String address;
  String description;
  List<String> images;
  String? speciality;

  Place({
    required this.name,
    required this.address,
    required this.description,
    required this.images,
    this.speciality,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'images': images,
      'speciality': speciality,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'],
      address: map['address'],
      description: map['description'],
      speciality: map['speciality'],
      images: List<String>.from(map['images']),
    );
  }
}
