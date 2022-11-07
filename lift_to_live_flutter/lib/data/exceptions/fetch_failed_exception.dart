class FetchFailedException implements Exception {
  String cause;
  FetchFailedException(this.cause);
}