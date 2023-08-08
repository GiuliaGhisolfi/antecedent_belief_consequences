import 'rabbia.dart';
import 'paura.dart';
import 'tristezza.dart';
import 'disgusto.dart';
import 'felicita.dart';
import 'sorpresa.dart';


enum Emotion {
  nessuna,
  rabbia,
  paura,
  tristezza,
  disgusto,
  felicita,
  sorpresa;
  
  @override
  String toString() {
    switch (this) {
      case nessuna:
        return 'Nessuna emozione';
      case rabbia:
        return 'Rabbia';
      case paura:
        return 'Paura';
      case tristezza:
        return 'Tristezza';
      case disgusto:
        return 'Disgusto';
      case felicita:
        return 'Felicità';
      case sorpresa:
        return 'Sorpresa';
    }
  }
}

enum Nessuna {
  nessuna;

  @override
  String toString() {
    switch (this) {
      case nessuna:
        return 'Nessuna emozione';
    }
  }
}

enum NessunaAssociated{
  nessuna,
  nessuna1;

  @override
  String toString() {
    switch (this) {
      case nessuna:
        return 'Nessuna emozione';
      case nessuna1:
        return 'Nessuna emozione';
    }
  }
}

class EmotionMapping {
  static Map<Emotion, List<dynamic>>
  secondaryEmotionMap = {
    Emotion.rabbia: Rabbia.values,
    Emotion.paura: Paura.values,
    Emotion.tristezza: Tristezza.values,
    Emotion.disgusto: Disgusto.values,
    Emotion.felicita: Felicita.values,
    Emotion.sorpresa: Sorpresa.values,
    Emotion.nessuna: Nessuna.values,
  };
}