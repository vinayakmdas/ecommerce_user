import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/features/home/presentation/screens/product_details.dart';
import 'package:ecommerce_fasion/routes/app_pages.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFAFAFA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchText = value.toLowerCase();
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: "Search shoes, shirts, brands...",
            ),
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('status', isEqualTo: 'active')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          final filtered = docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;

            final productName =
                data["productName"].toString().toLowerCase();

            final category =
                data["category"].toString().toLowerCase();

            final brand =
                data["brandId"].toString().toLowerCase();

            return productName.contains(searchText) ||
                category.contains(searchText) ||
                brand.contains(searchText);
          }).toList();

          if (filtered.isEmpty) {
            return const Center(
              child: Text(
                "No Products Found",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: filtered.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .65,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final data =
                  filtered[index].data() as Map<String, dynamic>;
  final doc = docs[index];
              final variant = data["variants"][0];
                      

              return GestureDetector(
                onTap: (){
                    AppRouter.push(
        context,
        ProductDetailsScreen(
          productData: data,
          productId: doc.id,
        ),
      );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.grey.withOpacity(.1),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                          child: Image.network(
                            variant["images"][0],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["productName"],
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                
                            const SizedBox(height: 4),
                
                            Text(
                              data["brandId"],
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                
                            const SizedBox(height: 8),
                
                            Row(
                              children: [
                                Text(
                                  "₹${variant["price"]}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                
                                const SizedBox(width: 8),
                
                                Text(
                                  "₹${variant["regularPrise"]}",
                                  style: const TextStyle(
                                    decoration:
                                        TextDecoration
                                            .lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}