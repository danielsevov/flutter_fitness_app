/// This is a custom Exception class, used to indicate a failed data fetch.
class FailedFetchException implements Exception {
  // The cause of the exception or the message it brings.
  String cause;

  //Simple constructor for creating an exception by passing the cause message.
  FailedFetchException(this.cause);
}
