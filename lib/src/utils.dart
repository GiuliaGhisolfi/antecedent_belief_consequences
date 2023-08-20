import '../enum/emotions.dart';
import '../enum/rabbia.dart';
import '../enum/paura.dart';
import '../enum/tristezza.dart';
import '../enum/disgusto.dart';
import '../enum/felicita.dart';
import '../enum/sorpresa.dart';
import 'package:flutter/material.dart';

List<dynamic> emotionsFromRow(String emotion, String secondaryEmotion, String tertiaryEmotions) {
  dynamic temporarySecondaryEmotion;
  dynamic temporaryTertiaryEmotions;
  bool secondaryEmotionFlag = true;

  if (secondaryEmotion == 'Nessuna emozione') {
    temporarySecondaryEmotion = Nessuna.values[0];
    secondaryEmotionFlag = false;
  }
  if (tertiaryEmotions == 'Nessuna emozione') {
    temporaryTertiaryEmotions = Nessuna.values[0];
  } else {
    switch (emotion) {
      case 'Rabbia':
        if (secondaryEmotionFlag) temporarySecondaryEmotion = Rabbia.values.firstWhere((element) => element.toString() == secondaryEmotion);
        temporaryTertiaryEmotions = RabbiaAssociated.values.firstWhere((element) => element.toString() == tertiaryEmotions);
        break;
      case 'Tristezza':
        if (secondaryEmotionFlag) temporarySecondaryEmotion = Tristezza.values.firstWhere((element) => element.toString() == secondaryEmotion);
        temporaryTertiaryEmotions = TristezzaAssociated.values.firstWhere((element) => element.toString() == tertiaryEmotions);
        break;
      case 'Paura':
        if (secondaryEmotionFlag) temporarySecondaryEmotion = Paura.values.firstWhere((element) => element.toString() == secondaryEmotion);
        temporaryTertiaryEmotions = PauraAssociated.values.firstWhere((element) => element.toString() == tertiaryEmotions);
        break;
      case 'Disgusto':
        if (secondaryEmotionFlag) temporarySecondaryEmotion = Disgusto.values.firstWhere((element) => element.toString() == secondaryEmotion);
        temporaryTertiaryEmotions = DisgustoAssociated.values.firstWhere((element) => element.toString() == tertiaryEmotions);
        break;
      case 'Felicità':
        if (secondaryEmotionFlag) temporarySecondaryEmotion = Felicita.values.firstWhere((element) => element.toString() == secondaryEmotion);
        temporaryTertiaryEmotions = FelicitaAssociated.values.firstWhere((element) => element.toString() == tertiaryEmotions);
        break;
      case 'Sorpresa':
        if (secondaryEmotionFlag) temporarySecondaryEmotion = Sorpresa.values.firstWhere((element) => element.toString() == secondaryEmotion);
        temporaryTertiaryEmotions = SorpresaAssociated.values.firstWhere((element) => element.toString() == tertiaryEmotions);
        break;
    }
  }
  return [temporarySecondaryEmotion, temporaryTertiaryEmotions];
}

List<dynamic> getSelectableTertiaryEmotions(
  int selectedEmotionIndex , List<dynamic> tertiaryEmotionList
  ) {
  final List<dynamic> selectableTertiaryEmotions = [];

  selectableTertiaryEmotions.add(tertiaryEmotionList[selectedEmotionIndex * 2]);
  selectableTertiaryEmotions.add(tertiaryEmotionList[selectedEmotionIndex * 2 + 1]);

  return selectableTertiaryEmotions;
} 

Widget buildEmotionCell(dynamic emotion, dynamic secondaryEmotion, dynamic tertiaryEmotions) {
  String emotionText = buildEmotionText(emotion, secondaryEmotion, tertiaryEmotions);
  return Text.rich(TextSpan(
            style: const TextStyle(color: Color.fromARGB(255, 150, 208, 245)),
            children: <TextSpan>[
              const TextSpan(text: 'Emozione: ', style: TextStyle(color: Color.fromARGB(255, 119, 187, 230))),
              TextSpan(text: emotionText, style: const TextStyle(color: Colors.black)),
            ],
          ),);
}

String buildEmotionText(dynamic emotion, dynamic secondaryEmotion, dynamic tertiaryEmotions) {
  if (emotion == Emotion.nessuna) {
    return  'Nessuna emozione inserita';
  } else if (secondaryEmotion == Nessuna.nessuna) {
    return '$emotion';
  } else if (tertiaryEmotions == Nessuna.nessuna) {
    return '$emotion, $secondaryEmotion';
  } else {
    return  '$emotion, $secondaryEmotion, $tertiaryEmotions';
  }
}