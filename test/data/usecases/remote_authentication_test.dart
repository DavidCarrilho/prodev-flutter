import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.httpClient,
    @required this.url,
  });

  Future<void> auth() async {
    await httpClient.request(
      url: url,
      method: 'post'
    );
  }
}

abstract class HttpClient {
  Future<void> request({
    @required String url,
    @required String method,
  }) {}
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClien with correct values', () async {
    // arrange
    // Sysytem Under Test
    final httpCLient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(
      httpClient: httpCLient,
      url: url,
    );
    // act
    await sut.auth();
    // assert
    verify(httpCLient.request(
      url: url,
      method: 'post',
    ));
  });
}
