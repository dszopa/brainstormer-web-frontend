import 'dart:convert';
import 'package:angular2/angular2.dart';
import 'dart:async';

import 'hero.dart';
import 'package:http/http.dart';

@Injectable()
class HeroService {

  static const _heroesUrl = 'api/heroes'; // URL to web API

  final Client _http;

  HeroService(this._http);

  dynamic _extractData(Response resp) => JSON.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // For demo purposes only
    return new Exception('Server error; cause: $e');
  }

  Future<List<Hero>> getHeroes() async {
    try {
      final response = await _http.get(_heroesUrl);
      final heroes = _extractData(response)
        .map((value) => new Hero.fromJson(value))
        .toList();
      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> getHero(int id) async {
    try {
      final response = await _http.get('$_heroesUrl/$id');
      return new Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  static final _headers = {'Content-Type': 'application/json'};
  Future<Hero> update(Hero hero) async {
    try {
      final url = '$_heroesUrl/${hero.id}';
      final response = await _http.put(url, headers: _headers, body: JSON.encode(hero));
      return new Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> create(String name) async {
    try {
      final response = await _http.post(_heroesUrl,
          headers: _headers, body: JSON.encode({'name': name}));
      return new Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> delete(int id) async {
    try {
      final url = '$_heroesUrl/$id';
      await _http.delete(url, headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
}