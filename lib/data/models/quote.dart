class QuoteModel {

  String quote;

  QuoteModel({this.quote});

  QuoteModel.fromJson(Map<String ,dynamic> json){
    this.quote = json['quote'];
  }

}