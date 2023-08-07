
class Note {
  final String antecedent; //antecedent: evento scatenate, stimolo di partenza
  final String belief; //belief: pensiero, convinzione per valutare lo stimolo di partenza
  final String consequence; //consequence: emozioni, comportamenti, reazioni;
  final dynamic emotion; //emozione primaria
  final dynamic secondaryEmotion; //emozione secondaria

  const Note({
    required this.antecedent,
    required this.belief,
    required this.consequence,
    required this.emotion,
    required this.secondaryEmotion,
  });
}
