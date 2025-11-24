
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/features/brandItems/presentaion/brandItem.dart';
import 'package:ecommerce_fasion/features/category/widget/category_widget.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/routes/app_pages.dart';
import 'package:flutter/material.dart';


class CategoryScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String categoryId;
  const CategoryScreen({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryWidget.imageContainer(context, imageUrl, name),
            SizedBox(height: 13),
            CategoryWidget.shopHeading(),
         

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('categoryId', isEqualTo: categoryId)
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("No brands found in this category"),
                    ),
                  );
                }
                final products = snapshot.data!.docs;

                final brands = <String>{};

                for (var doc in products) {
                  brands.add(doc["brandId"]);
                }
                final brandList = brands.toList();

                return ListView.separated(
                  itemCount: brandList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final brand = brandList[index];

                    return Card(
                      color: AppColors.container,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ), // adds outer spacing
                      child: Padding(
                        padding: const EdgeInsets.all(12.0), // inner spacing
                        child: ListTile(
                          title: Text(
                            brand,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                            ),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: AppColors.categoryTitle,
                            child: Icon(
                              Icons.arrow_circle_right_outlined,
                              color: AppColors.white,
                            ),
                          ),
                          onTap: () {
AppRouter.push(context, BrandItem(brandName: brand, categoryName: categoryId));
                                

                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 24),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
