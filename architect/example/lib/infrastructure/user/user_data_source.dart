import 'user_dto.dart';

class UserDataSource {
  Future<List<UserDTO>> getAll() async {
    return [
      UserDTO(1, 'User One'),
      UserDTO(2, 'User Two'),
    ];
  }

  Future<UserDTO> getById(int id) async {
    return UserDTO(1, 'User One');
  }
}
