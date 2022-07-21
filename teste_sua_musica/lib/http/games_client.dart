import 'dart:convert';

import 'package:http/http.dart';
import 'package:teste_sua_musica/models/game.dart';
import 'package:teste_sua_musica/models/twitch.dart';

import '../models/plataform.dart';

class GamesClient {
  final String _clientId = '4j7vrfe02zavku0wnxu23h1vq66367';
  final String _clientSecret = 'ghqq0cbj3gb3dxomt836x3bf3irhnx';
  final String _baseUrl = "https://api.igdb.com/v4";

  Future<String> _getAccessToken() async {
    Response response = await post(
      Uri.parse(
          'https://id.twitch.tv/oauth2/token?client_id=$_clientId&client_secret=$_clientSecret&grant_type=client_credentials'),
    );

    TwitchAuth twitchAuth = TwitchAuth.fromJson(jsonDecode(response.body));

    return twitchAuth.accessToken;
  }

  Future<List<Game>> getGames() async {
    String accessToken = await _getAccessToken();

    var response = await post(
      Uri.parse(
        '$_baseUrl/games',
      ),
      body: 'fields *;',
      headers: {
        'Client-ID': _clientId,
        'Authorization': "Bearer $accessToken",
        'Accept': 'application/json'
      },
    );

    final List decodedJson = jsonDecode(response.body);

    final List<Game> games =
        decodedJson.map((json) => Game.fromJson(json)).toList();

    return games;
  }

  Future<List<Plataform>> getPlataforms() async {
    String accessToken = await _getAccessToken();

    var response = await post(
      Uri.parse(
        '$_baseUrl/platforms/',
      ),
      body: 'fields *;',
      headers: {
        'Client-ID': _clientId,
        'Authorization': "Bearer $accessToken",
        'Accept': 'application/json'
      },
    );

    final List decodedJson = jsonDecode(response.body);

    final List<Plataform> plataforms =
        decodedJson.map((json) => Plataform.fromJson(json)).toList();

    return plataforms;
  }
}
