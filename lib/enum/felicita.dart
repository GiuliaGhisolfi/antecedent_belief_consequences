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

enum FelicitaAssociated {
  importante,
  fiducioso,
  provocatorio,
  coraggioso,
  amorevole,
  speranzoso,
  aperto,
  ispirato,
  liberato,
  estasiato,
  delicato,
  giocoso,
  curioso,
  divertito,
  rispettato,
  soddisfatto;

  @override
  String toString() {
    switch (this) {
      case importante:
        return 'Importante';
      case fiducioso:
        return 'Fiducioso';
      case provocatorio:
        return 'Provocatorio';
      case coraggioso:
        return 'Coraggioso';
      case amorevole:
        return 'Amorevole';
      case speranzoso:
        return 'Speranzoso';
      case aperto:
        return 'Aperto';
      case ispirato:
        return 'Ispirato';
      case liberato:
        return 'Liberato';
      case estasiato:
        return 'Estasiato';
      case delicato:
        return 'Delicato';
      case giocoso:
        return 'Giocoso';
      case curioso:
        return 'Curioso';
      case divertito:
        return 'Divertito';
      case rispettato:
        return 'Rispettato';
      case soddisfatto:
        return 'Soddisfatto';
    }
  }
}