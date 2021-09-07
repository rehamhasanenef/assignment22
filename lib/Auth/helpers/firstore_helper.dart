import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsg2_app/Auth/models/contre.dart';
import 'package:gsg2_app/Auth/models/register_request.dart';
import 'package:gsg2_app/Auth/models/user_model.dart';
import 'package:gsg2_app/Auth/ui/register_page.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      await firebaseFirestore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } on Exception catch (e) {
      print(e);
    }
  }

 Future<UserModel> getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(userId).get();

    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((e) => UserModel.fromMap(e.data())).toList();

    return users;
  }

  Future<List<CountryModel>> getAllCountries() async {
    try {
      QuerySnapshot querySnapshot =
          await firebaseFirestore.collection('countries').get();
      List<CountryModel> countries = querySnapshot.docs.map((e) {
        Map map = e.data();
        map['id'] = e.id;
        return CountryModel.fromJson(map);
      }).toList();
      return countries;
    } on Exception catch (e) {
      // TODO
    }
  }
}
