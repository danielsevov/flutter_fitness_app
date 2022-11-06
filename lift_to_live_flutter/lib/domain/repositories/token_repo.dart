import '../entities/token.dart';

abstract class TokenRepository {
  Future<String> getToken(String email, String password);
}