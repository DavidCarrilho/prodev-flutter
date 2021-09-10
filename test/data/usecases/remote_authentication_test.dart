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
  AuthenticationParams params;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
  });
  test('Should call HttpClien with correct values', () async {
     when(httpClient.request( url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenAnswer((_) async => {'accessToekn': faker.guid.guid(), 'name': faker.person.name()});
    // act
    await sut.auth(params);
    // assert
    verify(httpClient.request(url: url, method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClient.request( url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

   test('Should throw UnexpectedError if HttpClient returns 404', () async {
     when(httpClient.request( url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpError.notFound);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

   test('Should throw UnexpectedError if HttpClient returns 500', () async {
     when(httpClient.request( url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpError.serverError);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
  
   test('Should throw InvalidCredentialsError if HttpClient returns 401', () async {
     when(httpClient.request( url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpError.unautorized);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });

   test('Should return an Account if HttpClient returns 200', () async {
     final accessToken = faker.guid.guid();
     when(httpClient.request( url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenAnswer((_) async => {'accessToken': accessToken, 'name': faker.person.name()});
    final account = await sut.auth(params);
    expect(account.token, accessToken);
  });
}
