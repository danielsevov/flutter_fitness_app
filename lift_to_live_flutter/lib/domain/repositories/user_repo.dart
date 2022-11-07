import 'package:flutter/material.dart';

import '../entities/user.dart';
import '../entities/role.dart';

abstract class UserRepository {
  Future<List<Role>> fetchUserRoles(String jwtToken);

  Future<User> fetchUser(String userId, String jwtToken);

  Future<Image> fetchProfileImage(String userId, String jwtToken);
}