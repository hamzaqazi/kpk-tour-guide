import 'package:cloud_firestore/cloud_firestore.dart';

class HotelsService {
  final CollectionReference _hotelsCollection =
      FirebaseFirestore.instance.collection('hotels');

  Future<void> addHotel(Map<String, dynamic> data) async {
    await _hotelsCollection.add(data);
  }

  Future<void> updateHotel(String id, Map<String, dynamic> data) async {
    await _hotelsCollection.doc(id).update(data);
  }

  Future<void> deleteHotel(String id) async {
    await _hotelsCollection.doc(id).delete();
  }

  // getHotels method returns a Hotel object
  Future<QuerySnapshot<Object?>> getHotels() async {
    var hotel = await _hotelsCollection.get();
    hotel.docs.forEach((element) {
      print(element.data());
    });

    return _hotelsCollection.get();
  }

  // getHotelById method returns a Hotel object
  Future<DocumentSnapshot<Object?>> getHotelById(String id) async {
    return _hotelsCollection.doc(id).get();
  }
}
