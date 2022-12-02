import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/colors.dart';
import 'package:teamsta/constants/controllers.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubContacts extends StatelessWidget {
  const ClubContacts({Key? key}) : super(key: key);

  checkFormat(var value) {
    if (GetUtils.isPhoneNumber(value)) {
      return Icons.phone;
    } else if (GetUtils.isEmail(value)) {
      return Icons.email;
    } else
      return Icons.web;
  }

  @override
  Widget build(BuildContext context) {
    if (servicesController.contactList.value.length == 0) {
      return Center(
        child: Text(
          'No contacts at this time',
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: servicesController.contactList.value.length,
        itemBuilder: (context, int index) {
          return Column(
            children: [
              CustomContactsCard(
                title: Text(
                  servicesController.contactList.value[index].name,
                  style: Theme.of(context).textTheme.headline2,
                ),
                subtitle: servicesController.contactList.value[index].value,
                icon: checkFormat(
                    servicesController.contactList.value[index].value),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomContactsCard extends StatelessWidget {
  const CustomContactsCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  final Widget title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () async {
          if (GetUtils.isPhoneNumber(subtitle)) {
            if (subtitle.contains('07')) {
              launchUrl(Uri.parse('tel:+44${subtitle.substring(1)}'));
            } else {
              launchUrl(Uri.parse("tel:$subtitle"));
            }
          } else if (GetUtils.isEmail(subtitle)) {
            launchUrl(Uri.parse("mailto:$subtitle"));
          } else if (GetUtils.isURL(subtitle)) {
            if (subtitle.contains("https")) {
              launchUrl(Uri.parse(subtitle));
            } else {
              launchUrl(Uri.parse("https://$subtitle"));
            }
          } else {
            Get.snackbar('Error', 'This is not a valid number',
                colorText: Colors.white);
          }
        },
        child: Card(
          child: ListTile(
            title: title,
            subtitle: Text(
              subtitle,
              style: Theme.of(context).textTheme.headline3,
            ),
            trailing: Icon(
              icon,
              color: customOrange,
            ),
          ),
        ),
      ),
    );
  }
}

// class PhoneNumbers extends StatelessWidget {
//   const PhoneNumbers({
//     Key? key,
//     required this.phoneNumberMap,
//   }) : super(key: key);

//   final Map<String, dynamic> phoneNumberMap;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: phoneNumberMap.keys
//           .toList()
//           .map((key) => Column(
//                 children: [
//                   Text(
//                     key.toString(),
//                     style: Theme.of(context).textTheme.headline2,
//                   ),
//                   Text(
//                     phoneNumberMap[key].toString(),
//                     style: Theme.of(context).textTheme.headline3,
//                   )
//                 ],
//               ))
//           .toList(),
//     );
//   }
// }

// class EmailAddresses extends StatelessWidget {
//   const EmailAddresses({
//     Key? key,
//     required this.emailAddressMap,
//   }) : super(key: key);

//   final Map<String, dynamic> emailAddressMap;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: emailAddressMap.keys
//           .toList()
//           .map((key) => Text("$key: ${emailAddressMap[key]}"))
//           .toList(),
//     );
//   }
// }

// class WebAddresses extends StatelessWidget {
//   const WebAddresses({
//     Key? key,
//     required this.webAddressMap,
//   }) : super(key: key);

//   final Map<String, dynamic> webAddressMap;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: webAddressMap.keys
//           .toList()
//           .map((key) => Text("$key: ${webAddressMap[key]}"))
//           .toList(),
//     );
//   }
// }
