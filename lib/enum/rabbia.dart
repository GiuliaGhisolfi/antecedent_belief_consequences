enum Rabbia {
  aggressivo,
  critico,
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

enum RabbiaAssociated {
  ostile,
  provocato,
  sarcastico,
  scettico,
  sospettoso,
  asociale,
  infuriato,
  irriato,
  rancoroso,
  violato,
  devastato,
  imbarazzato,
  imbestialito,
  furioso,
  insicuro,
  geloso;

  @override
  String toString() {
    switch (this) {
      case ostile:
        return 'Ostile'; 
      case provocato:
        return 'Provocato';
      case sarcastico:
        return 'Sarcastico';
      case scettico:
        return 'Scettico';
      case sospettoso:
        return 'Sospettoso';
      case asociale:
        return 'Asociale';
      case infuriato:
        return 'Infuriato';
      case irriato:
        return 'Irriato';
      case rancoroso:
        return 'Rancoroso';
      case violato:
        return 'Violato';
      case devastato:
        return 'Devastato';
      case imbarazzato:
        return 'Imbarazzato';
      case imbestialito:
        return 'Imbestialito';
      case furioso:
        return 'Furioso';
      case insicuro:
        return 'Insicuro';
      case geloso:
        return 'Geloso';
    }
  }
}