import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/http_exception.dart';
import '../providers/product.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';

class Products with ChangeNotifier {
  static List<Product?> defaultProducts = [
    /*Product(
      id: 'p1',
      title: 'Chair',
      description: 'The chair combines comfort with bold contemporary forms.',
      price: 29.99,
      imageUrl:
          'https://glowbom.netlify.app/v1.1.3/img/presets/store/chair-small.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Couch',
      description: 'This is the most comfortable couch ever.',
      price: 59.99,
      imageUrl:
          'https://glowbom.netlify.app/v1.1.3/img/presets/store/couch-small.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Table',
      description: 'Perfect for family meals and dinner parties.',
      price: 19.99,
      imageUrl:
          'https://glowbom.netlify.app/v1.1.3/img/presets/store/table-small.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Bed',
      description: 'It works with all mattresses.',
      price: 49.99,
      imageUrl:
          'https://glowbom.netlify.app/v1.1.3/img/presets/store/bed-small.jpg',
    ),*/
  ];
  List<Product?>? _items = defaultProducts;

  static List<Product?> get copyDefaultProducts {
    return [...defaultProducts];
  }

  List<Product?> get items {
    return [..._items!];
  }

  List<Product?> get favoriteItems {
    return _items!.where((element) => element!.isFavorite!).toList();
  }

  Product? findById(String? id) {
    return _items!.firstWhere((prod) => prod!.id == id);
  }

  final String? authToken;
  final String? userId;

  Products(this.authToken, this.userId, this._items);

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    // In order to filter by userId on the server side
    // 1. url =  Auth.URL + '/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"';
    // 2. set index on Firebase Rules
    // "products": {
    //   ".indexOn": ["creatorId"]
    // }

    if (authToken == null) {
      return;
    }

    String filterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';

    var url = Auth.URL + '/products.json?auth=$authToken$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }

      url = Auth.URL + '/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(Uri.parse(url));
      final favoriteData =
          json.decode(favoriteResponse.body) as Map<String, dynamic>?;

      final List<Product?> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        );
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product? value) async {
    if (authToken != null) {
      final url = Auth.URL + '/products.json?auth=$authToken';
      try {
        final response = await http.post(
          Uri.parse(url),
          body: json.encode({
            'title': value!.title,
            'description': value.description,
            'price': value.price,
            'imageUrl': value.imageUrl,
            'creatorId': userId,
          }),
        );
        final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: value.title,
          description: value.description,
          price: value.price,
          imageUrl: value.imageUrl,
        );
        _items!.add(newProduct);
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {
      final newProduct = Product(
        id: DateTime.now().toIso8601String(),
        title: value!.title,
        description: value.description,
        price: value.price,
        imageUrl: value.imageUrl,
      );
      _items!.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(String? id, Product? value) async {
    final prodIndex = _items!.indexWhere((element) => element!.id == id);
    if (prodIndex >= 0) {
      if (authToken != null) {
        final url = Auth.URL + '/products/$id.json?auth=$authToken';
        await http.patch(
          Uri.parse(url),
          body: json.encode({
            'title': value!.title,
            'description': value.description,
            'price': value.price,
            'imageUrl': value.imageUrl,
          }),
        );
      }
      _items![prodIndex] = value;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String? id) async {
    final url = Auth.URL + '/products/$id.json?auth=$authToken';
    final existingProductIndex =
        _items!.indexWhere((element) => element!.id == id);
    var existingProduct = _items![existingProductIndex];
    _items!.removeAt(existingProductIndex);
    notifyListeners();
    if (authToken != null) {
      try {
        final response = await http.delete(Uri.parse(url));
        if (response.statusCode >= 400) {
          throw HttpException('Could not delete product.');
        }
        existingProduct = null;
      } catch (error) {
        _items!.insert(existingProductIndex, existingProduct);
        notifyListeners();
      }
    }
  }
}
