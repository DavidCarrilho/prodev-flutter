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
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({@required String url}) {}
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClien with correct URL', () async {
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
    verify(httpCLient.request(url: url));
  });
}
