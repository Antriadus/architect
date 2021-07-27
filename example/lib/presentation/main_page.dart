import 'package:flutter/material.dart';
import 'package:example/infrastructure/user/user_dto.dart';

class MainPage extends StatelessWidget {
  final dto = UserDTO(0, "name");
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      color: Colors.grey,
    );
  }
}

class UserDTOWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
