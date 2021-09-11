class CharacterModel {

  int id;
  String name;
  String nickName;
  String image;
  List<dynamic> occupation;
  String status;
  List<dynamic> appearance;
  String actorName;
  String category;
  List<dynamic> betterCallSaulAppearance;

  CharacterModel.fromJson(Map<String, dynamic> json){
    id = json['char_id'];
    name = json['name'];
    nickName = json['nickname'];
    image = json['img'];
    occupation = json['occupation'];
    status = json['status'];
    appearance = json['appearance'];
    actorName = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_a ppearance'];
  }

}