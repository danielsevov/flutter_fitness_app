/// Entity class for holding a single JWTToken instance.
class Token {
  final String token; // the JWT token

  //Simple constructor for creating the Token instance
  Token(this.token);

  // Function used for transforming a JSON to an Token object.
  Token.fromJson(Map<String, dynamic> json) : token = json['token'];

  // Function used for transforming a Token object to JSON map.
  Map<String, dynamic> toJson() => {
        'token': token,
      };

  //Equals function
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Token &&
          runtimeType == other.runtimeType &&
          token == other.token;

  //Hashcode function
  @override
  int get hashCode => token.hashCode;
}
