import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unit_test_tautorial/ApiServices/api_service.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiService = ApiService(dio: mockDio);
  });

  group("Fetch Posts", () {
    test(
      "return a list of Pots if http Complte Succefully",
      () async {
        when(mockDio.get("https://jsonplaceholder.typicode.com/posts"))
            .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(
                      path: 'https://jsonplaceholder.typicode.com/posts'),
                  statusCode: 200,
                  data: [
                    {
                      'id': 1,
                      'title': 'Test Post 1',
                      'body': 'This is a test post'
                    },
                    {
                      'id': 2,
                      'title': 'Test Post 2',
                      'body': 'This is another test post'
                    },
                  ],
                ));

        final posts = await apiService.fetchData();

        expect(posts.length, 2);
        expect(posts[0].title, 'Test Post 1');
        expect(posts[1].title, 'Test Post 2');
      },
    );

    test(
      "throws an exception if the http call completes with an error",
      () async {
        when(mockDio.get("https://jsonplaceholder.typicode.com/posts"))
            .thenThrow(DioException(
                requestOptions: RequestOptions(
                    path: 'https://jsonplaceholder.typicode.com/posts'),
                error: "SomeThing Went Wrong"));

        expect(apiService.fetchData(), throwsA(isInstanceOf<Exception>()));
      },
    );

    test(
      "throws an exception if the http call completes with NON 200 Status code",
      () async {
        when(mockDio.get("https://jsonplaceholder.typicode.com/posts"))
            .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(
                      baseUrl: "https://jsonplaceholder.typicode.com/posts"),
                  data: "not found",
                  statusCode: 404,
                ));

        expect(apiService.fetchData(), throwsA(isInstanceOf<Exception>()));
      },
    );
  });
}
