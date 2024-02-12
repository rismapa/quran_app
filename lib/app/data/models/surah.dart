import 'dart:convert';

// Get Surah from https://api.quran.gading.dev/surah

Surah surahFromJson(String str) => Surah.fromJson(json.decode(str));

String surahToJson(Surah data) => json.encode(data.toJson());

class Surah {
  final int? number;
  final int? sequence;
  final int? numberOfVerses;
  final Name? name;
  final Revelation? revelation;
  final Tafsir? tafsir;

  Surah({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
  });

  factory Surah.fromJson(Map<String, dynamic>? json) => Surah(
        number: json?["number"],
        sequence: json?["sequence"],
        numberOfVerses: json?["numberOfVerses"],
        name: Name.fromJson(json?["name"]),
        revelation: Revelation.fromJson(json?["revelation"]),
        tafsir: Tafsir.fromJson(json?["tafsir"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": name?.toJson(),
        "revelation": revelation?.toJson(),
        "tafsir": tafsir?.toJson(),
      };
}

class Name {
  final String? short;
  final String? long;
  final Translation? transliteration;
  final Translation? translation;

  Name({
    required this.short,
    required this.long,
    required this.transliteration,
    required this.translation,
  });

  factory Name.fromJson(Map<String, dynamic>? json) => Name(
        short: json?["short"],
        long: json?["long"],
        transliteration: Translation.fromJson(json?["transliteration"]),
        translation: Translation.fromJson(json?["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
        "transliteration": transliteration?.toJson(),
        "translation": translation?.toJson(),
      };
}

class Translation {
  final String? en;
  final String? id;

  Translation({
    required this.en,
    required this.id,
  });

  factory Translation.fromJson(Map<String, dynamic>? json) => Translation(
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic>? toJson() => {
        "en": en,
        "id": id,
      };
}

class Revelation {
  final String? arab;
  final String? en;
  final String? id;

  Revelation({
    required this.arab,
    required this.en,
    required this.id,
  });

  factory Revelation.fromJson(Map<String, dynamic>? json) => Revelation(
        arab: json?["arab"],
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic>? toJson() => {
        "arab": arab,
        "en": en,
        "id": id,
      };
}

class Tafsir {
  final String? id;

  Tafsir({
    required this.id,
  });

  factory Tafsir.fromJson(Map<String, dynamic>? json) => Tafsir(
        id: json?["id"],
      );

  Map<String, dynamic>? toJson() => {
        "id": id,
      };
}
