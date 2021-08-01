import 'package:example/presentation/main_page.dart';

class UserDTO {
  final int id;
  final String name;

  UserDTO(this.id, this.name);

  UserDTOWidget getWidget() {
    return UserDTOWidget();
  }
}
