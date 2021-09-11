import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/businessLogic/cubits/characters_cubit.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsView extends StatefulWidget {
  final CharacterModel character;
  CharacterDetailsView(this.character);

  @override
  _CharacterDetailsViewState createState() => _CharacterDetailsViewState();
}

class _CharacterDetailsViewState extends State<CharacterDetailsView> {

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getQuotes(widget.character.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCharacterInfo('Job : ', widget.character.occupation.join(' / ')),
                    buildDivider(315),
                    buildCharacterInfo('Appeared in : ', widget.character.category),
                    buildDivider(250),
                    buildCharacterInfo('Seasons : ', widget.character.appearance.join(' / ')),
                    buildDivider(280),
                    buildCharacterInfo('Status : ', widget.character.status),
                    buildDivider(300),
                    if(widget.character.betterCallSaulAppearance != null && widget.character.betterCallSaulAppearance.isNotEmpty)
                      buildCharacterInfo('Better Call Saul Seasons : ', widget.character.betterCallSaulAppearance.join(' / ')),
                    if(widget.character.betterCallSaulAppearance != null && widget.character.betterCallSaulAppearance.isNotEmpty)
                      buildDivider(150),
                    buildCharacterInfo('Actor/Actress : ', widget.character.actorName),
                    buildDivider(235),
                    BlocBuilder<CharactersCubit, CharactersState>(
                      builder: (context, state) => checkIfQuoteLoaded(state),
                    ),
                    SizedBox(height: 500),
                  ],
                ),
              ),
            ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar()=> SliverAppBar(
    expandedHeight: 600,
    backgroundColor: AppColors.accentColor,
    pinned: true,
    stretch: true,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(widget.character.nickName,style: TextStyle(color: AppColors.whiteColor),),
      background: Hero(tag: widget.character.id, child: Image.network(widget.character.image,fit: BoxFit.cover,)),
    ),
  );

  Widget buildCharacterInfo(String key,String value)=> RichText(
    maxLines: 1,
    overflow: TextOverflow.fade,
    text: TextSpan(
      children: [
        TextSpan(
          text: key,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w900
          ),
          children: [
            TextSpan(
                text: value,
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 15,
                )
            )
          ]
        )
      ],
    ),
  );

  Widget buildDivider(double endIndent)=> Divider(
    height: 30,
    color: AppColors.primaryColor,
    endIndent: endIndent,
  );

  Widget checkIfQuoteLoaded(CharactersState state){
    if(state is CharacterQuoteLoaded)
      return displayRandomQuoteOrEmptySpace(state);
    else
      return showProgressIndicator();
  }

  Widget showProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  Widget displayRandomQuoteOrEmptySpace(state){
    var quotes = (state).quotes;
    if(quotes.length != null){
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,color: AppColors.primaryColor, shadows: [Shadow(
            blurRadius: 7,
            color: AppColors.primaryColor,
            offset: Offset(0, 0),
          )]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    }else{
      return Text('');
    }
  }
}