// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:teamsta/models/servicesModels.dart';

// import '../constants/strings.dart';

// import 'package:http/http.dart' as http;

// class GetAllController {
//   var getAllTeam = RxList<AllTeamModel>().obs;
//   var getAllPlayer = RxList<AllUserModel>().obs;

//   final url = baseUrl + "all_info";

//   // headers
//   Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     "App-Key": env("APP_KEY"),
//     "Authorization": "Bearer $accessToken",
//   };

//   // get all data
//   getAll() async {
//     final newUrl = Uri.parse(url);

//     final response = await http.get(
//       newUrl,
//       headers: headers,
//     );

//     var jsonResponse = json.decode(response.body);

//     try {
//       switch (response.statusCode) {
//         case 200:
//           print(jsonResponse["teams"]);
//           for (Map<String, dynamic> result in jsonResponse['teams']) {
//             getAllTeam.value.add(AllTeamModel.fromJson(result));
//           }
//           for (Map<String, dynamic> result in jsonResponse
//               ['app_users']) {
//             getAllPlayer.value.add(AllUserModel.fromJson(result));
//           }
//           // getAllList.value.addAllIf(, items)
//           // getAllList.value.add(AllInfoModel.fromJson(jsonResponse));
//           break;
//         default:
//           print(response.statusCode);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
