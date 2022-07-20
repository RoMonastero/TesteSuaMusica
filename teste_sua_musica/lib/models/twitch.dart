class TwitchAuth {
  final String accessToken;
  final int expiresIn;
  final String tokenType;

  TwitchAuth(
      {required this.accessToken,
      required this.expiresIn,
      required this.tokenType});

  TwitchAuth.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        expiresIn = json['expires_in'],
        tokenType = json['token_type'];
}
