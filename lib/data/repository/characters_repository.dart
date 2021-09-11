import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/data/models/quote.dart';
import 'package:breaking_bad/data/webServices/characters_web_services.dart';

class CharactersRepository {
  CharactersRepository(this.charactersWebServices);
  final CharactersWebServices charactersWebServices;

  Future<List<CharacterModel>> getCharacters()async{
    final characters = await charactersWebServices.getCharacters();
    return characters.map((character) => CharacterModel.fromJson(character)).toList();
  }

  Future<List<QuoteModel>> getCharacterQuote(String author)async{
    final quotes = await charactersWebServices.getCharacterQuote(author);
    return quotes.map((quote) => QuoteModel.fromJson(quote)).toList();
  }

}