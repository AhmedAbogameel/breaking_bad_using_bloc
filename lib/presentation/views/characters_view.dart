import 'package:breaking_bad/businessLogic/cubits/characters_cubit.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersView extends StatefulWidget {
  @override
  _CharactersViewState createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  List<CharacterModel> characters;
  List<CharacterModel> searchedCharacters = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: isSearching ? BackButton(color: AppColors.accentColor,) : Text(''),
        title: isSearching ? buildSearchField() : Text(
          'Characters',
          style: TextStyle(color: AppColors.accentColor),
        ),
        actions: buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }

  Widget buildBlocWidget() => BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if(state is CharactersLoaded) {
            characters = state.characters;
            return buildLoadedListWidgets();
          } else
            return showLoadingIndicator();
        },
      );

  Widget showLoadingIndicator()=> Center(child: CircularProgressIndicator());

  Widget buildLoadedListWidgets()=> SingleChildScrollView(
    child: Container(
      color: AppColors.accentColor,
      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        itemCount: isSearching ? searchedCharacters.length : characters.length,
        itemBuilder: (context, index) => CharacterCard(isSearching ? searchedCharacters[index] : characters[index]),
      ),
    ),
  );

  Widget buildSearchField()=> TextField(
    controller: searchController,
    cursorColor: AppColors.accentColor,
    decoration: InputDecoration(
      hintText: 'Find a character...',
      border: InputBorder.none,
    ),
    onChanged: searchForCharacter,
  );

  void searchForCharacter(String value){
    searchedCharacters = characters.where((element) => element.name.toLowerCase().startsWith(value)).toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions(){
    if(isSearching){
      return [IconButton(icon: Icon(Icons.clear,color: AppColors.accentColor,), onPressed: (){
        _stopSearching();
        Navigator.pop(context);
      })];
    }else{
      return [IconButton(icon: Icon(Icons.search,color: AppColors.accentColor,), onPressed: _startSearch)];
    }
  }

  void _startSearch(){
    ModalRoute.of(context).addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(()=> isSearching = true);
  }

  void _stopSearching(){
    _clearSearch();
    setState(()=> isSearching = false);
  }

  void _clearSearch(){
    searchController.clear();
  }

}
