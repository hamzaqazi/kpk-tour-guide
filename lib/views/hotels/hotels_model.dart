class Hotel {
  String name;
  String address;
  double price;
  double? lat;
  double? lon;
  String? placeID;
  List<String> images;

  Hotel({
    required this.name,
    required this.address,
    required this.price,
    this.lat,
    this.lon,
    this.placeID,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'price': price,
      'lat': lat,
      'lon': lon,
      'placeID': placeID,
      'images': images,
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'],
      address: map['address'],
      price: map['price'],
      lat: map['lat'],
      lon: map['lon'],
      placeID: map['placeID'],
      images: List<String>.from(map['images']),
    );
  }
}
