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

enum TristezzaAssociated {
  isolato,
  abbandonato,
  pentito,
  disonorevole,
  vulnerabile,
  impotente,
  inferiore,
  vuoto,
  indifferente,
  apatico,
  vittimizzato,
  ignorato;

  @override
  String toString() {
    switch (this) {
      case isolato:
        return 'Isolato';
      case abbandonato:
        return 'Abbandonato';
      case pentito:
        return 'Pentito';
      case disonorevole:
        return 'Disonorevole';
      case vulnerabile:
        return 'Vulnerabile';
      case impotente:
        return 'Impotente';
      case inferiore:
        return 'Inferiore';
      case vuoto:
        return 'Vuoto';
      case indifferente:
        return 'Indifferente';
      case apatico:
        return 'Apatico';
      case vittimizzato:
        return 'Vittimizzato';
      case ignorato:
        return 'Ignorato';
    }
  }
}