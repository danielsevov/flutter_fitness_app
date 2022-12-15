import '../entities/image.dart';
import '../entities/user.dart';
import '../entities/role.dart';

/// API to the User repository object.
/// Defines method to be implemented.
abstract class UserRepository {
  /// This function is used for fetching a list of Role objects, describing the user role of a user.
  Future<List<Role>> fetchUserRoles(String jwtToken);

  /// This function is used for fetching a User object, containing user details.
  Future<User> fetchUser(String userId, String jwtToken);

  /// This function is used for fetching all trainees profiles of the current user.
  Future<List<User>> fetchMyTrainees(String userId, String jwtToken);

  /// This function is used for fetching all Image objects of a user.
  Future<List<MyImage>> fetchUserImages(String userId, String jwtToken);

  /// This function is used for fetching a Image object, which holds the profile picture of a user.
  Future<MyImage> fetchProfileImage(String userId, String jwtToken);

  /// This function is used for patching a Image object, which holds the picture of a user.
  Future<void> patchImage(int id, String userId, String date, String encoded, String type, String jwtToken);

  /// This function is used for posting a Image object, which holds the picture of a user.
  Future<void> postImage(String userId, String date, String encoded, String type, String jwtToken);

  /// This function is used to delete a image.
  Future<void> deleteImage(int id, String jwtToken);

  /// This function is used for fetching a list of all coach Role objects.
  Future<List<Role>> fetchCoachRoles(String jwtToken);

  /// This function is used for registering a user.
  Future<void> registerUser(String userId, String coachId, String password, String name, String phoneNumber, String nationality, String dateOfBirth, String jwtToken);
}
