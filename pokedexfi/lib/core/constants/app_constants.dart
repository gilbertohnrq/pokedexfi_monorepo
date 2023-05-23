import 'package:flutter/material.dart';

import '../domain/models/common/common_model.dart';
import '../domain/models/pokemon/pokemon_models.dart';

const String kBaseUrl = 'https://pokeapi.co/api/v2/';
const String kLimit = 'limit=20';
const Duration kAnimationDuration = Duration(milliseconds: 300);
const String kCacheKey = 'all_pokemons';

const Poke kMockedPoke = Poke(
  id: 1,
  name: 'Pikachu',
  height: 40,
  weight: 60,
  other: Other(
    officialArtwork: OfficialArtwork(
      frontDefault: 'https://example.com/pikachu.png',
    ),
  ),
  types: [
    Type(
      color: Colors.yellow,
      name: 'Electric',
      slot: 1,
    ),
  ],
  stats: [
    Stat(
      baseStat: 55,
      effort: 0,
      stat: Common(name: 'HP', url: 'https://example.com/hp.png'),
    ),
    Stat(
      baseStat: 40,
      effort: 0,
      stat: Common(name: 'Attack', url: 'https://example.com/attack.png'),
    ),
    Stat(
      baseStat: 35,
      effort: 0,
      stat: Common(name: 'Defense', url: 'https://example.com/defense.png'),
    ),
    Stat(
      baseStat: 50,
      effort: 0,
      stat: Common(
          name: 'Special Attack',
          url: 'https://example.com/special_attack.png'),
    ),
    Stat(
      baseStat: 50,
      effort: 0,
      stat: Common(
          name: 'Special Defense',
          url: 'https://example.com/special_defense.png'),
    ),
    Stat(
      baseStat: 90,
      effort: 2,
      stat: Common(name: 'Speed', url: 'https://example.com/speed.png'),
    ),
  ],
  abilities: [
    Ability(
      ability: Common(name: 'Static', url: 'https://example.com/static.png'),
      slot: 1,
    ),
    Ability(
      ability: Common(
          name: 'Lightning Rod', url: 'https://example.com/lightning_rod.png'),
      slot: 2,
    ),
  ],
);
