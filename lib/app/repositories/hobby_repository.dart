import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/hobby_models/hobby_model.dart';
import '../modules/common/controllers/user_controller.dart';

class HobbyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<HobbyModel> addHobby(HobbyModel hobbyModel) async {
    var ref = _firestore.collection("Hobby");
    var documentRef = await ref.add({'name': hobbyModel.name, "user_id": Get.find<UserController>().user!.uid});
    hobbyModel.id = documentRef.id;
    return hobbyModel;
  }

  Future<List<HobbyModel>> getAllHobby() async {
    var ref = _firestore.collection("Hobby").where("user_id", isEqualTo: Get.find<UserController>().user!.uid);
    var documents = await ref.get();
    List<HobbyModel> hobbies = [];
    for (var document in documents.docs) {
      HobbyModel hobbyModel = HobbyModel.fromJson(document.data());
      hobbyModel.id = document.id;
      hobbies.add(hobbyModel);
    }
    return hobbies;
  }

  Future<void> removeHobby(String docId) {
    var ref = _firestore.collection("Hobby").doc(docId).delete();
    return ref;
  }
}
