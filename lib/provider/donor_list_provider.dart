import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_db/models/donor_model.dart';

class DonorListProvider with ChangeNotifier {
  Box? box;

  addDonorData(Donor donor) async {
    box = await Hive.openBox('donorList');
    box!.add(donor.toMap());
    notifyListeners();
  }

  deleteDonorData(int index) async {
    box = await Hive.openBox('donorList');
    box!.deleteAt(index);
    notifyListeners();
  }

  updateDonorData(int index, String name, String bloodGroup, String address,
      String mobile) async {
    box = await Hive.openBox('donorList');
    Hive.box('donorList').putAt(
      index,
      Donor(
        name: name,
        bloodGroup: bloodGroup,
        address: address,
        mobile: mobile,
      ).toMap(),
    );
    notifyListeners();
  }
}
