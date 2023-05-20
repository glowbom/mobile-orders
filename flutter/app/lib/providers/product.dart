import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool? isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  Future<void> toggleFavoriteStatus(String? token, String? userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite!;
    notifyListeners();

    if (token != null) {
      final url = Auth.URL + '/userFavorites/$userId/$id.json?auth=$token';
      try {
        final response = await http.put(
          Uri.parse(url),
          body: json.encode(
            isFavorite,
          ),
        );

        if (response.statusCode >= 400) {
          isFavorite = oldStatus;
          notifyListeners();
        }
      } catch (error) {
        isFavorite = oldStatus;
        notifyListeners();
        print(error);
      }
    }
  }
}
