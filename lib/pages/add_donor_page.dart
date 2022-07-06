import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_db/models/donor_model.dart';

class AddNewDonor extends StatefulWidget {
  const AddNewDonor({Key? key}) : super(key: key);

  @override
  State<AddNewDonor> createState() => _AddNewDonorState();
}

class _AddNewDonorState extends State<AddNewDonor> {
  Box? box;

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    mobileController.dispose();
    bloodGroupController.dispose();
    addressController.dispose();
  }

  @override
  void initState() {
    super.initState();
    openBox();
  }

  void openBox() async {
    box = await Hive.openBox('donorList');
  }

  String dropDownItem = 'A+';

  List<String> bloodGroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.04),

                //Donor name
                TextFormField(
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: const Text(
                      'Donor name',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                //Mobile number
                TextFormField(
                  controller: mobileController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: const Text(
                      'Mobile Number',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                //Address
                TextFormField(
                  controller: addressController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: const Text(
                      'Address',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                //Blood Group
                Container(
                  width: width,
                  height: height * 0.075,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: DropdownButton(
                    underline: Container(),
                    onChanged: (String? value) {
                      setState(() {
                        dropDownItem = value!;
                      });
                    },
                    value: dropDownItem,
                    items: bloodGroup.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Donor donor = Donor(
            name: nameController.text,
            bloodGroup: dropDownItem,
            address: addressController.text,
            mobile: mobileController.text,
          );
          box!.add(donor.toMap());
          Navigator.of(context).pop();
          setState(() {});
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
