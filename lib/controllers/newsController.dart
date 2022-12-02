import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/models/newsModel.dart';

class NewsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getNews();
  }

  var newsInfo = RxList<NewsModel>().obs;
// headers
  Map<String, String> appHeaders = {
    'Content-Type': 'multipart/form-data',
    // 'App-Key': dotenv.env['APP_KEY']!,
    'App-Key': env("APP_KEY"),
    'Accept': 'application/json',
    "authorization": "Bearer $accessToken",
  };

  RxBool isLoading = false.obs;

//* get news
  getNews() async {
    final url = baseUrl + "news";

    final Uri newUrl = Uri.parse(url);

    var response = await http.get(newUrl, headers: appHeaders);

    var jsonResponse = json.decode(response.body);

    try {
      print("status code: ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          isLoading.value = true;
          newsInfo.value.clear();
          for (Map<String, dynamic> item in jsonResponse) {
            newsInfo.value.add(NewsModel.fromJson(item));
          }
          newsInfo.value.refresh();
          isLoading.value = false;
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        case 500:
          print(response.statusCode);
          print(jsonResponse);
          print(response.reasonPhrase);
          break;
        default:
      }
    } catch (e) {
      print(e.toString());
    }
  }

//* set news
  setNews(
    String title,
    String description,
    String newsUrl,
    String? image,
  ) async {
    final url = baseUrl + "news";

    final Uri newUrl = Uri.parse(url);

    final uploadRequest = await http.MultipartRequest(
      'POST',
      newUrl,
    )
      ..headers.addAll(appHeaders)
      ..fields.addAll({
        'title': title,
        'description': description,
        'url': newsUrl,
      });
    if (image != null) {
      uploadRequest.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image,
        ),
      );
    }

    var response = await http.Response.fromStream(await uploadRequest.send());
    var jsonResponse = json.decode(response.body);
    try {
      switch (response.statusCode) {
        case 201:
          print(jsonResponse);
          newsInfo.value.add(NewsModel.fromJson(jsonResponse['news']));
          newsInfo.value.refresh();
          // await getNews();
          // newsInfo.value.refresh();
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

//* delete news
  deleteNews(
    int id,
  ) async {
    final url = baseUrl + "news/$id";

    final Uri newUrl = Uri.parse(url);

    var response = await http.delete(newUrl, headers: appHeaders);

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 202:
          print("done");
          print(jsonResponse);
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

//* update news
  updateNews({
    required int id,
    required String title,
    required String description,
    required String uploadUrl,
    required File? image,
    required int imageID,
    bool? wasImage,
  }) async {
    Map<String, String> jsonHeaders = {
      'Content-Type': 'application/json',
      // 'App-Key': dotenv.env['APP_KEY']!,
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final url = baseUrl + "news/$id";

    final Uri newUrl = Uri.parse(url);

    var response = await http.put(newUrl,
        headers: jsonHeaders,
        body: jsonEncode({
          "title": title,
          "description": description,
          "url": uploadUrl,
        }));

    var jsonResponse = json.decode(response.body);
    print(id);
    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          print("normal Message: ${response.body}");
          if (image != null && wasImage == true) {
            deleteNewsImage(imageID, image, id);
          } else if (image != null && wasImage == false) {
            setNewsImage(id, image);
          }

          getNews();
          newsInfo.value.refresh();

          break;
        case 404:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* Delete nes image
  deleteNewsImage(int imageID, File image, int id) async {
    final url = baseUrl + "news/img_delete/$imageID";

    final Uri newUrl = Uri.parse(url);

    var response = await http.delete(newUrl, headers: appHeaders);

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print("done");
          print(jsonResponse);
          setNewsImage(id, image);
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* Set new news image
  setNewsImage(int id, File image) async {
    final url = baseUrl + "news/img_add/$id";

    final Uri newUrl = Uri.parse(url);

    final uploadRequest = await http.MultipartRequest(
      'POST',
      newUrl,
    )
      ..headers.addAll(appHeaders)
      ..fields.addAll({
        'id': id.toString(),
      });

    uploadRequest.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
      ),
    );

    var response = await http.Response.fromStream(await uploadRequest.send());
    var jsonResponse = json.decode(response.body);
    try {
      switch (response.statusCode) {
        case 200:
          print("new image set okay");
          print(jsonResponse);

          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
