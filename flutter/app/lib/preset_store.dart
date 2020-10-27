import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    if (_content == null) {
      loadContentFromAssets().then(
        (value) => setState(() {
          _content = value;
        }),
      );
    }
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
            previousProducts == null
                ? _content != null
                    ? _content['products']
                    : Products.defaultProducts
                : previousProducts.items,
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
                                : Colors.purple)
                : Colors.purple,
            accentColor: Colors.deepOrange,
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: widget.onlyEditor
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
                ''),
          },
        ),
      ),
    );
  }
}
