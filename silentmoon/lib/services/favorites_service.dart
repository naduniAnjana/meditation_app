import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silentmoon/model/morning_model.dart';

class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  static const String _favoritesKey = 'favorite_songs';

  Future<List<MorningModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
    return favoritesJson.map((jsonStr) {
      return MorningModel.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>);
    }).toList();
  }

  Future<void> saveFavorites(List<MorningModel> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson = favorites.map((model) => jsonEncode(model.toJson())).toList();
    await prefs.setStringList(_favoritesKey, favoritesJson);
  }

  Future<bool> isFavorite(MorningModel song) async {
    final favorites = await getFavorites();
    return favorites.any((element) => element.title == song.title && element.audio == song.audio);
  }

  Future<bool> toggleFavorite(MorningModel song) async {
    final favorites = await getFavorites();
    final existingIndex = favorites.indexWhere((element) => element.title == song.title && element.audio == song.audio);

    bool isNowFavorite = false;
    if (existingIndex >= 0) {
      favorites.removeAt(existingIndex);
      isNowFavorite = false;
    } else {
      favorites.add(song);
      isNowFavorite = true;
    }

    await saveFavorites(favorites);
    return isNowFavorite;
  }
}
