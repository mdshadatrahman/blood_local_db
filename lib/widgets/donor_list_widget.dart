import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_db/widgets/custom_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/donor_model.dart';

class DonorList extends StatelessWidget {
  const DonorList({
    Key? key,
    required this.donorList,
  }) : super(key: key);
  final List donorList;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: donorList.length,
      itemBuilder: (context, index) {
        var donor = Donor.fromMap(donorList[index]);

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    width: width,
                    height: height,
                    donor: donor,
                    index: index,
                  ),
                );
              },
              child: ListTile(
                title: Text(donor.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(donor.mobile),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: donor.mobile));
                          },
                          child: const Icon(
                            Icons.copy,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    Text(donor.address),
                  ],
                ),
                leading: Text(
                  donor.bloodGroup,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri(
                        scheme: 'tel',
                        path: donor.mobile,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 1,
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
