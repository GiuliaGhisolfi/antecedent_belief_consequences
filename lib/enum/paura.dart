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

enum PauraAssociated {
  sopraffatto,
  preoccupato,
  irrispettato,
  ridicolizzato,
  inadeguato,
  inferiore,
  alienato,
  inadeguato1,
  spaventato,
  terrorizzato,
  insignificante,
  indegno;

  @override
  String toString() {
    switch (this) {
      case sopraffatto:
        return 'Sopraffatto';
      case preoccupato:
        return 'Preoccupato';
      case irrispettato:
        return 'Irrispettato';
      case ridicolizzato:
        return 'Ridicolizzato';
      case inadeguato:
        return 'Inadeguato';
      case inferiore:
        return 'Inferiore';
      case alienato:
        return 'Alienato';
      case inadeguato1:
        return 'Inadeguato';
      case spaventato:
        return 'Spaventato';
      case terrorizzato:
        return 'Terrorizzato';
      case insignificante:
        return 'Insignificante';
      case indegno:
        return 'Indegno';
    }
  }
}