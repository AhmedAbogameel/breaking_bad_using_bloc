part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  CharactersLoaded(this.characters);
  final List<CharacterModel> characters;
}

class CharacterQuoteLoaded extends CharactersState {
  final List<QuoteModel> quotes;
  CharacterQuoteLoaded(this.quotes);
}