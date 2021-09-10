import 'package:appprodev/domain/entities/account_entity.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel({this.accessToken});

  factory RemoteAccountModel.fromJson(Map json) =>
      RemoteAccountModel(accessToken: json['accessToken']);

  AccountEntity toEntity() => AccountEntity(accessToken);
}
