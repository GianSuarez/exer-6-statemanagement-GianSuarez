import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget {
  const Checkout({super.key}); // Constructor for Checkout widget

  @override
  Widget build(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart; // Getting list of products from ShoppingCart provider
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Text('Item Details')), 
          products.isEmpty // Check if products list is empty
          ? const Text('No items to checkout!') // Display text if no items in the cart
          : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(products[index].name), // Display item name
                    trailing: Text(products[index].price.toString(), style: const TextStyle(fontSize: 14)), // Display item price
                  );
                },
              )),
              const Divider(height: 4, color: Colors.black),
              Flexible(
                  child: Center(
                      child: Column(
                          children: [
                            Text("Total Cost to Pay: ${context.read<ShoppingCart>().cartTotal.toString()}"), // Display total cost to pay
                    ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar( // Show snackbar with payment success message
                            content: Text("Payment Successful!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                          context.read<ShoppingCart>().removeAll(); // removeall() Removes all items from the cart and sets the total back to zero
                          // Pop current route from navigation stack in order to go back to the home page or catalog window.
                          // We could also use Navigator.pushNamed(context, "/products"); but it will create another product window in which if we click the back button, it will go to the original products page / home page
                          // so pop would be also useful if we don't want to create another products window.  
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
