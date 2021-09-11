import 'package:breaking_bad/constants/strings.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {

  Dio dio;

  CharactersWebServices(){
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: 1000 * 20,
      connectTimeout: 1000 * 20,
    );
    dio = Dio(baseOptions);
  }

  Future<List> getCharacters()async{
    try{
      Response response = await dio.get('characters');
      return response.data;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<List> getCharacterQuote(String author)async{
    try{
      Response response = await dio.get('quote', queryParameters: {'author' : author});
      return response.data;
    }catch(e){
      print(e);
      return [];
    }
  }
}