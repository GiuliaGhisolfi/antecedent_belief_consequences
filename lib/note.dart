
class Note {
  final String antecedent; //antecedent: evento scatenate, stimolo di partenza
  final String belief; //belief: pensiero, convinzione per valutare lo stimolo di partenza
  final String consequence; //consequence: emozioni, comportamenti, reazioni;
  final dynamic emotion; //emozione primaria
  final dynamic secondaryEmotion; //emozione secondaria
  final dynamic selectedTertiaryEmotions; //emozioni terziarie selezionate
  //final String? currentPlace; //posizione attuale
  final DateTime currentDateTime; //data e ora di creazione della nota

  const Note({
    required this.antecedent,
    required this.belief,
    required this.consequence,
    required this.emotion,
    required this.secondaryEmotion,
    required this.selectedTertiaryEmotions,
    //required this.currentPlace,
    required this.currentDateTime,
  });
}