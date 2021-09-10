import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:appprodev/domain/hepers/helpers.dart';
import 'package:appprodev/domain/usecases/authentication.dart';

import 'package:appprodev/data/usecases/usecases.dart';
import 'package:appprodev/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  // arrange
  // Sysytem Under Test
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(
      httpClient: httpClient,
      url: url,
    );
  });
  test('Should call HttpClien with correct values', () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
    // act
    await sut.auth(params);
    // assert
    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });

    test('Should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.badRequest);
    final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    final future =  sut.auth(params);
    // act
    // assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
