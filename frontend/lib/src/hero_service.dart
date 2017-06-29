import 'package:angular2/angular2.dart';
import 'dart:async';

import 'hero.dart';
import 'mock_heroes.dart';

@Injectable()
class HeroService {
  Future<List<Hero>> getHeroes() async => mockHeroes;
}