import 'package:clean_architecture_riverpod/layer/data/character_repository_impl.dart';
import 'package:clean_architecture_riverpod/layer/data/source/local/local_storage.dart';
import 'package:clean_architecture_riverpod/layer/data/source/network/api.dart';
import 'package:clean_architecture_riverpod/layer/domain/repository/character_repository.dart';
import 'package:clean_architecture_riverpod/layer/domain/usecase/get_all_characters.dart';
import 'package:clean_architecture_riverpod/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -----------------------------------------------------------------------------
// Presentation
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Domain
// -----------------------------------------------------------------------------
final characterRepositoryProvider = Provider<CharacterRepository>(
  (ref) => CharacterRepositoryImpl(
    api: ref.read(apiProvider),
    localStorage: ref.read(localStorageProvider),
  ),
);

final getAllCharactersProvider = Provider(
  (ref) => GetAllCharacters(
    repository: ref.read(characterRepositoryProvider),
  ),
);

// -----------------------------------------------------------------------------
// Data
// -----------------------------------------------------------------------------
final apiProvider = Provider<Api>((ref) => ApiImpl());

final localStorageProvider = Provider<LocalStorage>(
  (ref) => LocalStorageImpl(sharedPreferences: sharedPref),
);
