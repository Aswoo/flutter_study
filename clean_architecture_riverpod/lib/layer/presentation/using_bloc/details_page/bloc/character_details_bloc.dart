
import 'package:bloc/bloc.dart';
import 'package:clean_architecture_riverpod/layer/domain/entity/character.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'character_details_event.dart';

part 'character_details_state.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc({required Character character})
      : super(CharacterDetailsState(character: character));
}
