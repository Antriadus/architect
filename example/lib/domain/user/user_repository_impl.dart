import 'package:example/domain/user/user.dart';
import 'package:example/domain/user/user_repository.dart';
import 'package:example/infrastructure/user/user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final _dataSource = UserDataSource();
  final _fromDTOMapper = UserFromDTOMapper();

  @override
  Future<List<User>> getAll() async {
    final dtos = await _dataSource.getAll();
    return dtos.map((dto) => _fromDTOMapper(dto)).toList();
  }

  @override
  Future<User> getById(int id) async {
    final dto = await _dataSource.getById(id);
    return _fromDTOMapper(dto);
  }
}
