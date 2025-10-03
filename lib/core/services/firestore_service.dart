import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation/core/services/data_service.dart';
import 'package:graduation/features/auth/data/model/user_model.dart';
import 'package:graduation/features/auth/domain/entites/user_entity.dart';

class FirestoreServices implements DatabaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  //هنا عمللت دي عشان اقدر اضيف داتا بشكل عام للداتا بيز بتاعتنا
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(path).add(data);
  }

  @override
  Future<UserEntity> getUserDta({
    required String path,
    required String uId,
  }) async {
    var data = await firestore.collection(path).doc(uId).get();
    return UserModel.fromJson(data.data() as Map<String, dynamic>);
  }
}
