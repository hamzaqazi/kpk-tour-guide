class MallsModel {
  String name;
  String description;
  String image;
  String placeID;
  String address;

  MallsModel({
    required this.name,
    required this.description,
    required this.image,
    required this.placeID,
    required this.address,
  });

  // Factory method to create a PlaceModel instance from a map
  factory MallsModel.fromMap(Map<String, dynamic> map) {
    return MallsModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      placeID: map['placeID'] ?? '',
      address: map['address'] ?? '',
    );
  }

  // Method to convert the PlaceModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'placeID': placeID,
      'address': address,
    };
  }
}
