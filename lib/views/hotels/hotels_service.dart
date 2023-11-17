import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpksmartguide/views/hotels/hotels_model.dart';

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
  Future<List<Hotel>> getHotels() async {
    var hotel = await _hotelsCollection.get();
    List<Hotel> hotels = [];
    hotel.docs.forEach((element) {
      hotels.add(Hotel.fromMap(element.data() as Map<String, dynamic>));
    });

    return hotels;
  }

  // getHotelById method returns a Hotel object
  Future<DocumentSnapshot<Object?>> getHotelById(String id) async {
    return _hotelsCollection.doc(id).get();
  }
}
