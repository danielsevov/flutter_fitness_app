class Token {
  final String token;

  Token(this.token);

  Token.fromJson(Map<String, dynamic> json)
      : token = json['token'];

  Map<String, dynamic> toJson() => {
    'token': token,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Token &&
          runtimeType == other.runtimeType &&
          token == other.token;

  @override
  int get hashCode => token.hashCode;
}