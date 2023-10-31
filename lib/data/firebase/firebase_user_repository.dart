import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chatapp/data/repositories/user_repository.dart';
import 'package:flutter_chatapp/domain/entities/result.dart';
import 'package:flutter_chatapp/domain/entities/user.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firebaseFireStore;

  FirebaseUserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFireStore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<Result<User>> getUser({required String uid}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFireStore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    }
    return const Result.failed('User not found');
  }

  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name}) async {
    CollectionReference<Map<String, dynamic>> users =
        _firebaseFireStore.collection('users');
    await users.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
    });

    DocumentSnapshot<Map<String, dynamic>> result = await users.doc(uid).get();
    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('Failed to create user');
    }
  }
}
