import 'package:dio/dio.dart';
import 'package:unit_test_tautorial/ApiServices/post_model.dart';

class ApiService {
  Dio dio;
  ApiService({required this.dio});

  Future<List<Post>> fetchData() async {
    try {
      Response response =
          await dio.get("https://jsonplaceholder.typicode.com/posts");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((element) => Post.fromJson(element)).toList();
      } else {
        throw Exception("Something Went Wrong..");
      }
    } catch (error) {
      throw Exception("Failed To Load Posts $error");
    }
  }
}
