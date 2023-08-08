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

enum DisgustoAssociated {
  avversione,
  esitante,
  detestabile,
  repulsione,
  ripugnante,
  ribelle,
  giudicante,
  disgustato;

  @override
  String toString() {
    switch (this) {
      case avversione:
        return 'Avversione';
      case esitante:
        return 'Esitante';
      case detestabile:
        return 'Detestabile';
      case repulsione:
        return 'Repulsione';
      case ripugnante:
        return 'Ripugnante';
      case ribelle:
        return 'Ribelle';
      case giudicante:
        return 'Giudicante';
      case disgustato:
        return 'Disgustato';
    }
  }
}