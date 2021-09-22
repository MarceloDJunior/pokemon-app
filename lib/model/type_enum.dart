enum TypeEnum {
  normal,
  fire,
  fighting,
  water,
  flying,
  grass,
  poison,
  electric,
  ground,
  psychic,
  rock,
  ice,
  bug,
  dragon,
  ghost,
  dark,
  steel,
  fairy
}

extension TypeName on TypeEnum {
  String get name {
    switch (this) {
      case TypeEnum.normal:
        return 'Normal';
      case TypeEnum.fire:
        return 'Fire';
      case TypeEnum.fighting:
        return 'Fighting';
      case TypeEnum.water:
        return 'Water';
      case TypeEnum.flying:
        return 'Flying';
      case TypeEnum.grass:
        return 'Grass';
      case TypeEnum.poison:
        return 'Poison';
      case TypeEnum.electric:
        return 'Electric';
      case TypeEnum.ground:
        return 'Ground';
      case TypeEnum.psychic:
        return 'Psychic';
      case TypeEnum.rock:
        return 'Rock';
      case TypeEnum.ice:
        return 'Ice';
      case TypeEnum.bug:
        return 'Bug';
      case TypeEnum.dragon:
        return 'Dragon';
      case TypeEnum.ghost:
        return 'Ghost';
      case TypeEnum.dark:
        return 'Dark';
      case TypeEnum.steel:
        return 'Steel';
      case TypeEnum.fairy:
        return 'Fairy';
      default:
        return '';
    }
  }
}
