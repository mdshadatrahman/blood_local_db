class Donor {
  String name;
  String mobile;
  String address;
  String bloodGroup;

  Donor({
    required this.name,
    required this.bloodGroup,
    required this.address,
    required this.mobile,
  });

  factory Donor.fromMap(Map donor) {
    return Donor(
      name: donor['name'],
      bloodGroup: donor['bloodGroup'],
      address: donor['address'],
      mobile: donor['mobile'],
    );
  }

  Map toMap() {
    return {
      'name': name,
      'bloodGroup': bloodGroup,
      'address': address,
      'mobile': mobile,
    };
  }
}
