import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/hospital_visit.dart';
import 'package:dr_oh_app/model/medication_model.dart';

class MyHistoryRepository {
  // 검진기록, 내원이력, 투약이력 저장
  static Future<bool> addHospitalVisit(
      HospitalVisitModel hospitalVisitModel, String id) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
    var docId = data.docs.first.id;
    try {
      await FirebaseFirestore.instance
          .collection('users/$docId/HospitalVisit')
          .add(hospitalVisitModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addMedication(
      MedicationModel medicationModel, String id) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
    var docId = data.docs.first.id;
    try {
      await FirebaseFirestore.instance
          .collection('users/$docId/Medication')
          .add(medicationModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
