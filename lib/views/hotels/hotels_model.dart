class Hotel {
  String name;
  String? description;
  String address;
  double price;
  double? rating;
  double? lat;
  double? lon;
  String? placeID;
  List<String> images;

  Hotel({
    required this.name,
    required this.address,
    required this.price,
    this.rating,
    this.lat,
    this.lon,
    this.placeID,
    required this.images,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'price': price,
      'rating': rating,
      'lat': lat,
      'lon': lon,
      'placeID': placeID,
      'images': images,
      'description': description,
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'],
      address: map['address'],
      price: map['price'],
      rating: map['rating'],
      lat: map['lat'],
      lon: map['lon'],
      placeID: map['placeID'],
      images: List<String>.from(map['images']),
      description: map['description'],
    );
  }
}
