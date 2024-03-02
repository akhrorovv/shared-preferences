import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/credit_card_model.dart';

class Prefs {
  static storeCardList(List<CreditCard> cardList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cardListString =
        cardList.map((card) => jsonEncode(card.toMap())).toList();
    await prefs.setStringList('card_list', cardListString);
  }

  static Future<List<CreditCard>?> loadCardList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cardListString = prefs.getStringList("card_list");
    if (cardListString == null || cardListString.isEmpty) return null;

    List<CreditCard> cardList = cardListString
        .map((cardString) => CreditCard.fromMap(json.decode(cardString)))
        .toList();
    return cardList;
  }

  static Future<bool> removeCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("card_list");
  }
}
