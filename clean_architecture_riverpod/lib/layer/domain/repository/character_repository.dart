

import '../entity/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({int page = 0});
}
