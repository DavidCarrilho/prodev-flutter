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
  Map mockValidData() => {'accessToken': faker.guid.guid(), 'name': faker.person.name()};
  PostExpectation mockRquest() =>  when(httpClient.request( url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')));
  void mockHttpData (Map data) => mockRquest().thenAnswer((_) async => data);
  void mockHttpError (HttpError error) => mockRquest().thenThrow(error);

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    mockHttpData(mockValidData());
  });
  test('Should call HttpClient with correct values', () async {
    // act
    await sut.auth(params);
    // assert
    verify(httpClient.request(url: url, method: 'post', 
        body: {'email': params.email, 'password': params.secret}));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

   test('Should throw UnexpectedError if HttpClient returns 404', () async {
     mockHttpError(HttpError.notFound);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

   test('Should throw UnexpectedError if HttpClient returns 500', () async {
     mockHttpError(HttpError.serverError);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
  
   test('Should throw InvalidCredentialsError if HttpClient returns 401', () async {
     mockHttpError(HttpError.unautorized);
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });

   test('Should return an Account if HttpClient returns 200', () async {
     final validData = mockValidData();
     mockHttpData(validData);
    final account = await sut.auth(params);
    expect(account.token, validData['accessToken']);
  });

   test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    mockHttpData({'invalid_key': 'invalid_value'});
    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}
