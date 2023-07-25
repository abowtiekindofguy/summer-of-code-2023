import 'package:flutter/material.dart';
import 'product.dart';
import 'package:firebase_auth/firebase_auth.dart';

Product laptop1 = Product(id: '53', title: 'HP', category: 'laptop', price: 79.0, location: 'location', description: 'description', imageUrl: 'https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1689153301/Croma%20Assets/CMS/PCP/Laptop/Latest%20in%20tech/PCP_4Split_LIT_HPR5_12July2023_tbstjw.png?tr=w-720', metadataUser: 'metadataUser', isNegotiable: true, isFeatured: true, isPromoted: true);
Product laptop2 = Product(id: '53', title: 'HP', category: 'laptop', price: 79.0, location: 'location', description: 'description', imageUrl: 'https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1689153301/Croma%20Assets/CMS/PCP/Laptop/Latest%20in%20tech/PCP_4Split_LIT_HPR5_12July2023_tbstjw.png?tr=w-720', metadataUser: 'metadataUser', isNegotiable: true, isFeatured: true, isPromoted: true);
Product laptop3 = Product(id: '53', title: 'HP', category: 'laptop', price: 79.0, location: 'location', description: 'description', imageUrl: 'https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1689153301/Croma%20Assets/CMS/PCP/Laptop/Latest%20in%20tech/PCP_4Split_LIT_HPR5_12July2023_tbstjw.png?tr=w-720', metadataUser: 'metadataUser', isNegotiable: true, isFeatured: true, isPromoted: true);
Product laptop4 = Product(id: '53', title: 'HP', category: 'laptop', price: 79.0, location: 'location', description: 'description', imageUrl: 'https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1689153301/Croma%20Assets/CMS/PCP/Laptop/Latest%20in%20tech/PCP_4Split_LIT_HPR5_12July2023_tbstjw.png?tr=w-720', metadataUser: 'metadataUser', isNegotiable: true, isFeatured: true, isPromoted: true);
List<Product> productlist=[];

class LogoutButton extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    // After signing out, navigate back to the login screen
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signOut(context),
      child: Text('Logout'),
    );
  }
}
class HomeRoute extends StatelessWidget {
const HomeRoute({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
  List<Product> products = [laptop1,laptop2,laptop3,laptop4];
  
	return Scaffold(
	appBar: AppBar(
		title: const Text('IITD Electronics Market'),
		backgroundColor: Colors.blue,
	), // AppBar
	body: ListView(
		children:[ Column(
		mainAxisAlignment: MainAxisAlignment.center,
		children: <Widget>[
      DynamicBanner(imageUrls: ['https://dummyimage.com/200X300','https://dummyimage.com/300X200','https://dummyimage.com/250X300','https://dummyimage.com/200X350',],),
      ProductGridView(products: products),
      ProductTile(product: laptop1),
      LogoutButton(),
      ElevatedButton(
			child: const Text('Post Product!'),
			onPressed: () {
				Navigator.pushNamed(context, '/post-product');
			},
			),
			ElevatedButton(
			child: const Text('Click Me!'),
			onPressed: () {
				Navigator.pushNamed(context, '/second');
			},
			), // ElevatedButton
			ElevatedButton(
			child: const Text('Tap Me!'),
			onPressed: () {
				Navigator.pushNamed(context, '/third');
			},
			),
		],
		), ]
	), 
	);
}
}


