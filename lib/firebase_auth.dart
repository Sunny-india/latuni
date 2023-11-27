// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'models/customer_model.dart';
//
// class FirebaseRepository {
//   static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//
//   // // for storing images named on their email//
//   // static final firebase_storage.Reference ref = firebase_storage
//   //     .FirebaseStorage.instance
//   //     .ref('customerImages/${email}.jpg');
//
//   // static CollectionReference customers =
//   //     firebaseFirestore.collection('customers');
//
//   static void signUpWithEmail(CustomerModel customerModel) async {
//     await _firebaseAuth.createUserWithEmailAndPassword(
//         email: customerModel.email, password: customerModel.password!);
//   }
//
//   /// Not working because we did not have that password saved in model class. So what
//   /// could be the solution? todo:
// }
