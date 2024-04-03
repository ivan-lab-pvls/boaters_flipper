import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

enum PaymentType { weekly, monthly, annually }

class TypesMapper {
  static PaymentType paymentTypeParse(String title) {
    switch (title.toLowerCase()) {
      case 'weekly':
        return PaymentType.weekly;
      case 'monthly':
        return PaymentType.monthly;
      case 'annually':
        return PaymentType.annually;
      default:
        throw ArgumentError('Invalid payment type: $title');
    }
  }
  static BoatState boatStateParse(String title) {
    switch (title.toLowerCase()) {
      case 'perfect':
        return BoatState.perfect;
      case 'average':
        return BoatState.average;
      case 'bad':
        return BoatState.bad;
      default:
        throw ArgumentError('Invalid payment type: $title');
    }
  }
}
enum BoatState { perfect, average, bad }



class BoatModel {
  final String type;
  final double rentalCost;
  final PaymentType paymentType;
  final BoatState boatState;
  final String whoRents;
  final String comment;

  BoatModel({
    required this.type,
    required this.rentalCost,
    required this.paymentType,
    required this.boatState,
    required this.whoRents,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'rentalCost': rentalCost,
      'paymentType': paymentType.index, // Save enum as index
      'boatState': boatState.index, // Save enum as index
      'whoRents': whoRents,
      'comment': comment,
    };
  }

  factory BoatModel.fromJson(Map<String, dynamic> json) {
    return BoatModel(
      type: json['type'],
      rentalCost: json['rentalCost'],
      paymentType: PaymentType.values[json['paymentType']], // Retrieve enum by index
      boatState: BoatState.values[json['boatState']], // Retrieve enum by index
      whoRents: json['whoRents'],
      comment: json['comment'],
    );
  }

  static Future<void> saveToPrefs(String key, BoatModel boat) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(boat.toJson()));
  }

  static Future<BoatModel?> loadFromPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return BoatModel.fromJson(json.decode(jsonString));
    }
    return null;
  }
}
