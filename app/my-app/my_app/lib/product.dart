import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

class Product {
  final String id;
  final String title;
  final String category;
  final double price;
  final String location;
  final String description;
  final String imageUrl;
  final String metadataUser;
  final bool isNegotiable;
  final bool isFeatured;
  final bool isPromoted;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.metadataUser,
    required this.isNegotiable,
    required this.isFeatured,
    required this.isPromoted,
  });

  List<dynamic> CartRepresentation(){
    return []
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    bool isFavorite = true;

    return Stack(
      children: [
        InkWell(
          child: Container(
            width: 200,
            height: 200,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.black54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  product.category,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProductGridView extends StatelessWidget {
  final List<Product> products;

  ProductGridView({required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductTile(product: products[index]);
        },
      ),
    );
  }
}

class DynamicBanner extends StatelessWidget {
  final List<String> imageUrls;

  DynamicBanner({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          String imageUrl = imageUrls[index];
          return GestureDetector(
            onTap: () {
              // Handle image tap
              launchImageLink(imageUrl);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  void launchImageLink(String imageUrl) {
    print('Image tapped: $imageUrl');
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 16.0),
          Text(
            product.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Location: ${product.location}',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Description:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              GetStorage cartdb = GetStorage('Cart');
              int cartOccupied = cartdb.read('cartnumber') ?? 0;
              productdetails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Product added to cart')),
              );
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
