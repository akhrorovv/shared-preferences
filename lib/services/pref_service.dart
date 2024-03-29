import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/credit_card_model.dart';

class Prefs {
  static storeCardList(List<CreditCard> cards) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cardListString =
        cards.map((card) => jsonEncode(card.toMap())).toList();
    await prefs.setStringList('card_list', cardListString);
  }

  static Future<List<CreditCard>> loadCardList() async {
    List<CreditCard> myList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cardListString = prefs.getStringList("card_list");
    if (cardListString == null || cardListString.isEmpty) return myList;

    List<CreditCard> cards = cardListString
        .map((cardString) => CreditCard.fromMap(json.decode(cardString)))
        .toList();
    if (cards != null) {
      myList.addAll(cards);
    }
    return myList;
  }

  static Future<bool> removeCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("card_list");
  }
}
