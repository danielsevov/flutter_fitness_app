/// API to the Token repository object.
/// Defines method to be implemented.
abstract class TokenRepository {
  /// This function is used for fetching a Token object, containing the JWTToken.
  Future<String> getToken(String email, String password);
}
