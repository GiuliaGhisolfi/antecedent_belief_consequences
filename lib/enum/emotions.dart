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

enum Rabbia {
  aggressivo,
  critico,
  irritato,
  distaccato,
  frustrato,
  detestabile,
  ferito,
  arrabbiato,
  minacciato;

  @override
  String toString() {
    switch (this) {
      case aggressivo:
        return 'Aggressivo';
      case critico:
        return 'Critico';
      case irritato:
        return 'Irritato';
      case distaccato:
        return 'Distaccato';
      case frustrato:
        return 'Frustrato';
      case detestabile:
        return 'Detestabile';
      case ferito:
        return 'Ferito';
      case arrabbiato:
        return 'Arrabbiato';
      case minacciato:
        return 'Minacciato';
    }
  }
}

enum Disgusto {
  sfuggevole,
  orrore,
  deluso,
  disapprovazione;

  @override
  String toString() {
    switch (this) {
      case sfuggevole:
        return 'Sfuggevole';
      case orrore:
        return 'Orrore';
      case deluso:
        return 'Deluso';
      case disapprovazione:
        return 'Disapprovazione';
    }
  }
}

enum Paura {
  ansioso,
  umiliato,
  insicuro,
  respinto,
  impaurito,
  sottomesso;

  @override
  String toString() {
    switch (this) {
      case ansioso:
        return 'Ansioso';
      case umiliato:
        return 'Umiliato';
      case insicuro:
        return 'Insicuro';
      case respinto:
        return 'Respinto';
      case impaurito:
        return 'Impaurito';
      case sottomesso:
        return 'Sottomesso';
    }
  }
}

enum Felicita {
  orgoglioso,
  potente,
  trainquillo,
  ottimista,
  goioso,
  intimo,
  interessato,
  accettato;
  
  @override
  String toString() {
    switch (this) {
      case orgoglioso:
        return 'Orgoglioso';
      case potente:
        return 'Potente';
      case trainquillo:
        return 'Trainquillo';
      case ottimista:
        return 'Ottimista';
      case goioso:
        return 'Goioso';
      case intimo:
        return 'Intimo';
      case interessato: 
        return 'Interessato';
      case accettato:
        return 'Accettato';
    }
  }
}

enum Tristezza {
  solo,
  colpevole,
  disperato,
  depresso,
  annoiato,
  abbandonato;

  @override
  String toString() {
    switch (this) {
      case solo:
        return 'Solo';
      case colpevole:
        return 'Colpevole';
      case disperato:
        return 'Disperato';
      case depresso:
        return 'Depresso';
      case annoiato:
        return 'Annoiato';
      case abbandonato:
        return 'Abbandonato';
    }
  }
}

enum Sorpresa {
  spaventato,
  eccitato,
  confuso,
  stupito;

  @override
  String toString() {
    switch (this) {
      case spaventato:
        return 'Spaventato';
      case eccitato:
        return 'Eccitato';
      case confuso:
        return 'Confuso';
      case stupito:
        return 'Stupito';
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