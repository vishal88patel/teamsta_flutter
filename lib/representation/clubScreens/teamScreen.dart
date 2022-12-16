import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/controllers.dart';

class ClubTeam extends StatelessWidget {
  const ClubTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (servicesController.teamMemberList.value.length == 0) {
      return Center(
        child: Text(
          "No Team members to show",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }
    return ListView.builder(
      itemCount: servicesController.teamMemberList.value.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ClubTeamCard(
          name: servicesController.teamMemberList.value[index].name,
          position: servicesController.teamMemberList.value[index].role,
          image: servicesController.teamMemberList.value[index].images,
          description: servicesController.teamMemberList.value[index].bio,
        );
      },
    );
  }
}

class ClubTeamCard extends StatelessWidget {
  const ClubTeamCard({
    Key? key,
    required this.name,
    required this.position,
    required this.image,
    required this.description,
  }) : super(key: key);

  final String name;
  final String position;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          var data = {
            "name": name,
            "position": position,
            "image": image,
            "bio": description,
          };
          Get.toNamed('/teamBio', arguments: data);
        },
        child: Card(
          child: ListTile(
            title: Text(
              name,
              style: Theme.of(context).textTheme.headline3,
            ),
            subtitle: Text(
              position,
              style: Theme.of(context).textTheme.headline3,
            ),
            trailing: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(image)),
          ),
        ),
      ),
    );
  }
}
