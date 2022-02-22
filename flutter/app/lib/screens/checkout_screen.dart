import 'package:url_launcher/url_launcher.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/checkout';

  final bool showPhone;
  final bool showName;
  final bool showAddress;
  final String message;
  final String url;
  final String order;
  final String paymentLink;
  final Function checkoutFunction;

  CheckoutScreen(this.checkoutFunction, this.showPhone, this.showName,
      this.showAddress, this.message, this.url, this.order, this.paymentLink);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _address = '';
  var _phone = '';
  var _submitted = false;

  _launchLink(link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      Orders ordersData = Provider.of<Orders>(context, listen: false);
      String orderString = '';
      double price = 0.0;
      if (ordersData != null &&
          ordersData.orders != null &&
          ordersData.orders.length > 0) {
        OrderItem orderItem = ordersData.orders[ordersData.orders.length - 1];
        orderString += orderItem.dateTime.toIso8601String() + ', ';
        orderString += orderItem.amount.toString() + ', ';
        for (int i = 0; i < orderItem.products.length; i++) {
          CartItem product = orderItem.products[i];
          orderString += product.title + ', ';
          orderString += product.quantity.toString() + ', ';
          orderString += product.price.toString() + ', ';

          price += product.price * product.quantity;
        }
      }

      final url = widget.url;

      if (url != null && url.contains('http')) {
        http
            .get(Uri.parse(
                '$url?data=$_userEmail;$_userName;$_address;$_phone;$orderString'))
            .then((value) => print(value.body));
      }

      setState(() {
        _submitted = true;

        if (widget.paymentLink != null && widget.paymentLink != '') {
          _launchLink(widget.paymentLink.startsWith('http')
              ? '${widget.paymentLink}/$price'
              : 'https://${widget.paymentLink}/$price');
        }
      });

      widget.checkoutFunction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Container(
          constraints: new BoxConstraints(
            maxWidth: 360.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _submitted ? 'Thank you!' : widget.message,
                  style: TextStyle(
                    fontSize: 21,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // showScore is name
                      if (!_submitted && widget.showName)
                        TextFormField(
                          key: ValueKey('username'),
                          autocorrect: true,
                          textCapitalization: TextCapitalization.words,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter at least 1 character.';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      if (!_submitted)
                        TextFormField(
                          key: ValueKey('email'),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email address',
                          ),
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),

                      if (!_submitted && widget.showAddress)
                        TextFormField(
                          key: ValueKey('address'),
                          autocorrect: true,
                          textCapitalization: TextCapitalization.words,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter at least 1 character.';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Shipping address',
                          ),
                          onSaved: (value) {
                            _address = value;
                          },
                        ),

                      // showResult is name
                      if (!_submitted && widget.showPhone)
                        TextFormField(
                          key: ValueKey('phone'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 3) {
                              return 'Please enter at least 3 characters.';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            _phone = value;
                          },
                          onFieldSubmitted: (value) {
                            _trySubmit();
                          },
                        ),
                      SizedBox(height: 12),
                      if (!_submitted)
                        FlatButton(
                          child: Text(
                            'Place your order',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: _trySubmit,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
