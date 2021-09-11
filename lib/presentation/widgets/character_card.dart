import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/constants/strings.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
   CharacterCard(this.character);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: InkWell(
        onTap: ()=> Navigator.pushNamed(context, characterDetailsRoute,arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.id,
            child: Container(
              color: AppColors.accentColor,
              child: FadeInImage.assetNetwork(
              width: double.infinity,
                  placeholder: 'assets/images/loading.gif',
                  image: character.image,
              ),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            color: Colors.black54,
            child: Text(character.name,style: TextStyle(height: 1.3,fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.whiteColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
