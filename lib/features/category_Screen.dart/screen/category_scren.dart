import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/features/category_Screen.dart/widget/category_widget.dart';
import 'package:ecommerce_fasion/features/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';


class CategoryScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
   final String categoryId ;
  const CategoryScreen({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.categoryId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children:[ 
          CategoryWidget.imageContainer(context, imageUrl, name),
          SizedBox(height: 13,),
          CategoryWidget.shopHeading(),
          SizedBox(height: 10,),

          StreamBuilder<QuerySnapshot>(
            stream:  FirebaseFirestore.instance.collection('products').where('categoryId' , isEqualTo: categoryId ).snapshots(),
            
            
             builder: (context,snapshot){

              if(snapshot.connectionState==  ConnectionState.waiting){
                return   Center(child: CircularProgressIndicator());
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


              for(var doc in products){

                brands.add(doc["brandId"]);
              }
              final brandList = brands.toList();

              return  ListView.builder(
                itemCount: brandList.length,
                 shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context , index){

                   final brand = brandList[index];

                          return Card(
                            color: AppColors.scafoldBaground,
                            child: ListTile(
                              
                                                  title: Text(
                                                    brand,
                                                    style:  TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                                                    ),
                                                  ),
                            
                                                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                            
                                                  onTap: (){
                            
                                                  },
                            ),
                          );
                }
              );
             })
          ]),
      ),
    );
  }
}

