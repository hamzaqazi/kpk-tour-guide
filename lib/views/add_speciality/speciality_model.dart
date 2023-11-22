class Speciality {
  String title;
  String? description;
  String? category;
  String image;
  String placeID;

  Speciality({
    required this.title,
    required this.image,
    required this.placeID,
    this.description,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'Image': image,
      'placeID': placeID,
      'description': description,
      'category': category,
    };
  }

  factory Speciality.fromMap(Map<String, dynamic> map) {
    return Speciality(
      title: map['title'],
      image: map['Image'],
      placeID: map['placeID'],
      description: map['description'],
      category: map['category'],
    );
  }
}
