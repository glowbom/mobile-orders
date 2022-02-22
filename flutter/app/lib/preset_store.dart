import 'dart:convert';
import 'dart:math';

import './providers/product.dart';

import './screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './providers/auth.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/auth_screen.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail.dart';
import './screens/products_overview_screen.dart';
import './screens/splash_screen.dart';
import './screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MobileOrdersApp(null, false));
}

class MobileOrdersApp extends StatefulWidget {
  static String title = 'Mobile Orders';
  final dynamic content;
  final bool onlyEditor;
  MobileOrdersApp(this.content, this.onlyEditor);

  @override
  _MobileOrdersAppState createState() => _MobileOrdersAppState(content);
}

class _MobileOrdersAppState extends State<MobileOrdersApp> {
  dynamic _content;
  _MobileOrdersAppState(this._content);

  Future<dynamic> loadContentFromAssets() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/store.glowbom");
    return json.decode(data);
  }

  var _expired = false;

  @override
  void initState() {
    super.initState();
    if (_content == null) {
      loadContentFromAssets().then(
        (value) => setState(() {
          _content = value;
          List<Product> products = List<Product>();

          List<dynamic> loadedProducts = value['products'];

          for (int index = 0; index < loadedProducts.length; index++) {
            Product product = Product(
              description: loadedProducts[index]['description'],
              id: loadedProducts[index]['id'],
              title: loadedProducts[index]['title'],
              price: double.tryParse(loadedProducts[index]['price'].toString()),
              imageUrl: loadedProducts[index]['imageUrl'],
              isFavorite: loadedProducts[index]['isFavorite'],
            );
            products.add(product);
          }

          value['products'] = products;
        }),
      );
    }
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  @override
  Widget build(BuildContext context) {
    MobileOrdersApp.title =
        _content != null ? _content['title'] : 'Mobile Orders';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => null,
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            _content != null ? _content['products'] : Products.defaultProducts,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => null,
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: MobileOrdersApp.title,
          theme: ThemeData(
            primarySwatch: _content != null
                ? (_content['main_color'] == 'Blue'
                    ? Colors.blue
                    : _content['main_color'] == 'Green'
                        ? Colors.green
                        : _content['main_color'] == 'Red'
                            ? Colors.red
                            : _content['main_color'] == 'Grey'
                                ? Colors.grey
                                : _content['main_color'] == 'White'
                                    ? generateMaterialColor(Colors.white)
                                    : _content['main_color'] == 'Black'
                                        ? generateMaterialColor(Colors.black)
                                        : Colors.purple)
                : Colors.purple,
            accentColor: Colors.deepOrange,
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: _expired
              ? Scaffold(
                  body: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('The preview is no longer available.'),
                    ),
                  ),
                )
              : widget.onlyEditor
                  ? UserProductsScreen(widget.onlyEditor)
                  : auth.isAuth
                      ? ProductsOverviewScreen()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()
                                  : AuthScreen(),
                        ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) =>
                UserProductsScreen(widget.onlyEditor),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            CheckoutScreen.routeName: (ctx) => CheckoutScreen(
                  () {},
                  _content != null ? _content['show_number_result'] : false,
                  _content != null ? _content['show_percentage_result'] : false,
                  _content != null ? _content['voice'] : false,
                  _content != null
                      ? _content['conclusion']
                      : 'Thank you! Please enter your shipping information:',
                  _content != null ? _content['start_over'] : '',
                  '',
                  _content != null &&
                          (_content as Map<String, dynamic>)
                              .containsKey('payment_link')
                      ? _content['payment_link']
                      : '',
                ),
          },
        ),
      ),
    );
  }
}
