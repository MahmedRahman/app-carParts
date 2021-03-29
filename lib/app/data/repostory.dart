import 'dart:convert';
import 'package:carpart/app/data/auth.dart';
import 'package:carpart/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

String baes_url = 'https://carpart.atpnet.net/api/';


/*
String Tokan =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzY5MmRjMjE0ZmZiZjkyNmYwNmRjNWQxZGE3ZjE5YzM2YzJiMGE0YWFkZjM3ZDkwNTQwZTUyYTA4MDAwNjA4YjI0OTIwMTM0ZTU4NWZkZGIiLCJpYXQiOjE2MTY0MjIyNzEsIm5iZiI6MTYxNjQyMjI3MSwiZXhwIjoxNjQ3OTU4MjcxLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.f3gQSUKXfTArx4S5GxWc6NNXP-ZvKFDtHxhnRGNp6Githtrb_sdEPQCpuv3CCXIPSrJ5FeT1ZntXlhYRnIcrqmnIdq-ZApxL18g6k-3fMlcb8Yp5PW3p-VEoRh7NT2t96mMxeMH_KgzolrSk0_T7PIfXLkhBzj89UzV3q6OSDkenrC_4fiipv63niyQMJr43ijlx_pv-HYusjjVGgXTb6gBeXRauRCcJgB6V3IfsMM-9B1lhK1X_RkvefbtZVu8APdKmU7iUWhdPyrc16o7-ITYd0d4AsKvsZQyElQDOdH6WbqNBOcYSguvjwIk-pfzXuz8WevTZBluNWLMhAdWl6Wk_HPr0Hl4cc4aFh756EJwi7TdLejxuyDwjsDVz-do2fh1VmnE5iuF1gG2qOSQMq7Om9dcNJ0MB-ZskLZK_h3rM_McK4GtY29fUiKNXQ2VxnacNBmBDtIhMH67ukrwkPeCOaXdvaBSjC_RmwMwcDcx61kpd9XWyX4yibb_zsrvQ4PBnEwNsy_IZDRsDmk68ngQwBrUgkAzF1n8N_eurpJpqQfWy0jQsb8Lrsm_XHQxDVBQ9crcrPx1yPmbzd6OzGKBEtpdr16QXfwvQBiKpGwdfs1NzTpPpkBiRgYaJlWCKRRCrhBUk_V1TUV0jNU6UR4PKEnCBRXrcmyFmTna5qbE";
  */

class RepostoryProvide extends GetConnect {
  final header = {
    'Authorization': 'Bearer ',
  };

  Future<Response> repPost(url, body) async {
    print(baes_url + "/" + url);

    Response response = await post(baes_url + "/" + url, body, headers: header);

    try {
      switch (response.statusCode) {
        case 200:
        print(response.bodyString);
          //return response;
          if (isJsonParsable(response.bodyString)) {
            return response;
          } else {
            print(response.bodyString);
            Future.error('error');
            //Get.toNamed(Routes.SETTING);
          }
          break;
        default:
          print(response.statusCode);
          print(response.bodyString);
          //Get.toNamed(Routes.SplashView);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Response> repGet(url) async {
    print(baes_url + "/" + url);

    String tokan = Get.find<UserAuth>().getUserToken();

    print(tokan);

    if (tokan != null) {
      header.update(
        'Authorization',
        (value) {
          return 'Bearer ' + tokan;
        },
      );
    }

    Response response = await get(baes_url + "/" + url, headers: header);

    try {
      print(response.statusCode);

      switch (response.statusCode) {
        case 200:
          if (isJsonParsable(response.bodyString)) {
            return response;
          } else {
            print(response.bodyString);
           // Get.toNamed(Routes.SETTING);
          }

          break;
        default:
          print(response.bodyString);
         // Get.toNamed(Routes.SETTING);
      }
    } catch (e) {
      print(e);
      throw e;
    }

    //print(response.hasError);
  }

  bool isJsonParsable(String jsonString) {
    try {
      var decodedJSON = json.decode(jsonString) as Map<String, dynamic>;
      return true;
    } on FormatException catch (e) {
      return false;
    }
  }
/*
  var isJsonParsable = string => {
    try {
        JSON.parse(string);
    } catch (e) {
        return false;
    }
    return true;
}
*/
}
