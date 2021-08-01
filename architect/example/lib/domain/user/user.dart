import 'package:example/infrastructure/user/user_dto.dart';

class User {
  final int id;
  final String name;

  User(this.id, this.name);
}

class UserFromDTOMapper {
  User call(UserDTO dto) {
    return User(dto.id, dto.name);
  }
}
