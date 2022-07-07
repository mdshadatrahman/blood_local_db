import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_db/models/donor_model.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    Key? key,
    required this.width,
    required this.height,
    required var donor,
    required this.index,
  })  : _donor = donor,
        super(key: key);
  final double height;
  final double width;
  final dynamic _donor;
  final int index;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final addressController = TextEditingController();

  Box? box;

  late String dropDownItem;

  List<String> bloodGroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  bool isEditing = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    mobileController.dispose();
    bloodGroupController.dispose();
    addressController.dispose();
  }

  void editDonorInfo(
      String name, String mobile, String address, String bloodGroup) {
    if (nameController.text.isEmpty) {
      name = widget._donor.name;
    } else {
      name = nameController.text;
    }
    if (mobileController.text.isEmpty) {
      mobile = widget._donor.mobile;
    } else {
      mobile = mobileController.text;
    }
    if (addressController.text.isEmpty) {
      address = widget._donor.address;
    } else {
      address = addressController.text;
    }

    Hive.box('donorList').putAt(
      widget.index,
      Donor(
        name: name,
        bloodGroup: bloodGroup,
        address: address,
        mobile: mobile,
      ).toMap(),
    );
  }

  void openbox() async {
    box = await Hive.openBox('donorList');
  }

  @override
  void initState() {
    super.initState();
    dropDownItem = widget._donor.bloodGroup;
    openbox();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          height: widget.height * 0.7,
          width: widget.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(height: widget.height * 0.01),
              CircleAvatar(
                radius: 40,
                child: Text(
                  widget._donor.bloodGroup,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: widget.height * 0.01),
              SizedBox(
                width: widget.width * 0.7,
                child: TextFormField(
                  enabled: isEditing,
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: Text(
                      widget._donor.name,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: widget.height * 0.01),
              SizedBox(
                width: widget.width * 0.7,
                child: TextFormField(
                  controller: mobileController,
                  enabled: isEditing,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      label: Text(
                        widget._donor.mobile,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(height: widget.height * 0.01),
              SizedBox(
                width: widget.width * 0.7,
                child: TextFormField(
                  controller: addressController,
                  enabled: isEditing,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      label: Text(
                        widget._donor.address,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(height: widget.height * 0.01),
              Container(
                width: widget.width * 0.7,
                height: widget.height * 0.075,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.width * 0.02,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                ),
                child: AbsorbPointer(
                  absorbing: !isEditing,
                  child: DropdownButton(
                    underline: Container(),
                    icon: Container(),
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
              ),
              SizedBox(height: widget.height * 0.02),
              isEditing
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            editDonorInfo(
                              nameController.text,
                              mobileController.text,
                              addressController.text,
                              dropDownItem,
                            );
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            box!.deleteAt(widget.index);
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: const Text('Delete'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: const Text('Edit'),
                        )
                      ],
                    ),
              SizedBox(height: widget.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
