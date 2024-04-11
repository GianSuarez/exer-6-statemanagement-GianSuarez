import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Text('Item Details')), 
          products.isEmpty
          ? const Text('No items to checkout!')
          : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(products[index].name),
                    trailing: Text(products[index].price.toString(), style: const TextStyle(fontSize: 14)),
                  );
                },
              )),
              const Divider(height: 4, color: Colors.black),
              Flexible(
                  child: Center(
                      child: Column(
                          children: [
                            Text("Total Cost to Pay: ${context.read<ShoppingCart>().cartTotal.toString()}"),
                    ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Payment Successful!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                          context.read<ShoppingCart>().removeAll();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Pay Now!")),
                ]))),
              ],
            )),
        ],
      ),
    );
  }
}
