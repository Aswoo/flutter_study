import '../entity/character.dart';
import '../repository/character_repository.dart';

class GetAllCharacters {
  GetAllCharacters({
    required CharacterRepository repository,
  }) :  _repository = repository;

  final CharacterRepository _repository;

  Future<List<Character>> call({int page = 0}) async {
    final list = await _repository.getCharacters(page: page);
    return list;
  }
}