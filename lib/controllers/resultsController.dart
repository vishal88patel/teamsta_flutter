import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';

import 'package:http/http.dart' as http;
import 'package:teamsta/models/resultsModel.dart';

class ResultsController extends GetxController {
  var resultsInfo = RxList<ResultsModel>().obs;

  RxBool isLoading = false.obs;

  Map<String, String> appHeaders = {
    'Content-Type': 'application/json',
    'App-Key': env("APP_KEY"),
    'Accept': 'application/json',
    "Authorization": "Bearer $accessToken",
  };

  final url = baseUrl + "results";

//* get result
  getResult() async {
    final newUrl = Uri.parse(url);

    final response = await http.get(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    isLoading.toggle();

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);

          resultsInfo.value.clear();
          for (Map<String, dynamic> item in jsonResponse) {
            resultsInfo.value.add(ResultsModel.fromJson(item));
          }
          isLoading.toggle();
          break;
        case 401:
          print("401: ${response.reasonPhrase}");
          break;
        case 422:
          print(jsonResponse);
          break;
        case 500:
          print(jsonResponse);
          break;
      }
    } catch (e) {
      print(e);
    }
  }

//* create result
  Future<void> createResult({
    required int id,
    required int awayScore,
    required int homeScore,
    required String result,
  }) async {
    final newUrl = Uri.parse(url + "/$id");

    final response = await http.post(
      newUrl,
      headers: appHeaders,
      body: json.encode({
        "away_score": awayScore,
        "home_score": homeScore,
        "result": result,
      }),
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          print(jsonResponse);
          resultsInfo.value.clear();
          resultsInfo.value.add(ResultsModel.fromJson(jsonResponse["result"]));
          break;
        case 401:
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
          Get.offAllNamed('/login');
          break;
        case 422:
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
          break;
        case 500:
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
          break;
        default:
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
      }
    } catch (e) {
      print(e);
    }
  }

//* update result
  editResult({
    required int id,
    required String result,
    required String homeScore,
    required String awayScore,
    required String vs,
    required String description,
    required String date,
    required String time,
    String? address_line_1,
    String? address_line_2,
    String? town_or_city,
    String? county,
    String? post_code,
    final List<File>? editFile,
  }) async {
    final url = baseUrl + "results/$id";

    final newUrl = Uri.parse(url);
    isLoading.toggle();
    final response = await http.put(
      newUrl,
      headers: appHeaders,
      body: jsonEncode(
        {
          "result": result,
          "home_score": homeScore,
          "away_score": awayScore,
          "vs": vs,
          "description": description,
          "date": date,
          "time": time,
          "address_line_1": address_line_1,
          "address_line_2": address_line_2,
          "town_or_city": town_or_city,
          "county": county,
          "post_code": post_code,
        },
      ),
    );
    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          resultsInfo.value.clear();
          editFile!.length != 0
              ? updateResultsImages(id, editFile).then((_) async {
                  await getResult();
                  isLoading.toggle();
                  Get.back();
                })
              : {
                  await getResult(),
                  isLoading.toggle(),
                  Get.back(),
                };
          break;
        case 401:
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
          Get.offAllNamed('/login');
          break;
        default:
          isLoading.toggle();
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
          print(response.statusCode.toString() +
              response.reasonPhrase.toString() +
              jsonResponse.toString());
      }
    } catch (e) {
      print(e);
    }
  }

//* update results images
  updateResultsImages(int resultId, List<File> editFile) async {
    final url = baseUrl + "upload/result_images/$resultId";

    final newUrl = Uri.parse(url);

    List<http.MultipartFile> newList = [];
    for (int i = 0; i < editFile.length; i++) {
      newList.add(
        await http.MultipartFile.fromPath("images[$i]", editFile[i].path),
      );
    }

    final uploadRequest = await http.MultipartRequest("POST", newUrl)
      ..headers.addAll(appHeaders);
    if (newList.length > 0) {
      uploadRequest.files.addAll(newList);
    }
    var response = await uploadRequest.send();
    var jsonResponse = await response.stream.bytesToString();

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          imageFile.clear();
          break;
        default:
          Get.snackbar(
              "Error ${response.statusCode}", response.reasonPhrase.toString());
          print(response.statusCode.toString() +
              response.reasonPhrase.toString() +
              jsonResponse.toString());
      }
    } catch (e) {
      print("UpdateImageResults: $e");
    }
  }

//* delete result
  deleteResult(int id) async {
    final url = baseUrl + "results/$id";

    final newUrl = Uri.parse(url);

    final response = await http.delete(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          break;
        case 401:
          print("401: ${response.reasonPhrase}");
          break;
        case 422:
          print(jsonResponse);
          break;
        case 500:
          print(jsonResponse);
          break;
        default:
          print("${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error ----> $e");
    }
  }

  //* delete result image
  deleteResultImage(int id) async {
    final url = baseUrl + "results/img_delete/$id";

    final newUrl = Uri.parse(url);

    final response = await http.delete(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          break;
        case 401:
          print("401: ${response.reasonPhrase}");
          break;
        default:
          print("${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error ----> $e");
    }
  }
}
