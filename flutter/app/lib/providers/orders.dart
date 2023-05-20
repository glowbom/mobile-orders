import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';
import 'auth.dart';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    if (authToken == null) {
      return;
    }

    final url = Auth.URL + '/orders/$userId.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(
              orderData['dateTime'],
            ),
            products: (orderData['products'] as List<dynamic>)
                .map((e) => CartItem(
                      id: e['id'],
                      title: e['title'],
                      quantity: e['quantity'],
                      price: e['price'],
                    ))
                .toList(),
          ),
        );
      });

      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      //throw (error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Auth.URL + '/orders/$userId.json?auth=$authToken';
    final activeOrdersUrl = Auth.URL + '/orders/active.json?auth=$authToken';
    final timestamp = DateTime.now();
    try {
      if (authToken != null) {
        final response = await http.post(
          Uri.parse(url),
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price,
                    })
                .toList(),
          }),
        );
        _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timestamp,
            products: cartProducts,
          ),
        );
      } else {
        _orders.insert(
          0,
          OrderItem(
            id: timestamp.toIso8601String(),
            amount: total,
            dateTime: timestamp,
            products: cartProducts,
          ),
        );
      }

      notifyListeners();
      if (authToken != null) {
        await http.post(
          Uri.parse(activeOrdersUrl),
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'userId': userId,
            'products': cartProducts
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price,
                    })
                .toList(),
          }),
        );
      }
    } catch (error) {
      //throw error;
    }
  }
}
