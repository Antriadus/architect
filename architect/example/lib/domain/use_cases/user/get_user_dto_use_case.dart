import 'package:example/infrastructure/user/user_dto.dart';

class GetUserDTOUseCase {
  Future<UserDTO> call(int id) async => UserDTO(id, 'name');
}
