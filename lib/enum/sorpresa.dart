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

enum SorpresaAssociated {
  scioccato,
  scoraggiato,
  energetico,
  desideroso,
  perplesso,
  disilluso,
  meravigliato,
  stupito;

  @override
  String toString() {
    switch (this) {
      case scioccato:
        return 'Scioccato';
      case scoraggiato:
        return 'Scoraggiato';
      case energetico:
        return 'Energetico';
      case desideroso:
        return 'Desideroso';
      case perplesso:
        return 'Perplesso';
      case disilluso:
        return 'Disilluso';
      case meravigliato:
        return 'Meravigliato';
      case stupito:
        return 'Stupito';
    }
  }
}