import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/profile/presentation/screens/adres_addingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.categoryTitle,
        foregroundColor: Colors.white,
        title: const Text(
          "Saved Addresses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('addresses')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Column(
                       
              children: [
                Expanded(
                  child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center , 
                   
                    children: [
                      Icon(
                        Icons.location_off_outlined,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                  Text(
                    "No addresses found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Add your first delivery address",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                   
                    ],
                  ),
                ),
                
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 20,left: 25, right: 25),
                  child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddAddressPage(),
                      ),
                    );
                  },
                  child: _addNewAddressButton(),
                                ),
                ),  
              ],
            );
          }

          final addresses = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: addresses.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final data =
                          addresses[index].data() as Map<String, dynamic>;

                      final docId = addresses[index].id;

                      return _buildAddressCard(
                        label: "Delivery Address",
                        name: data['fullName'] ?? '',
                        phone: data['phone'] ?? '',
                        address:
                            "${data['door']}, ${data['street']}, ${data['city']}, ${data['district']}, ${data['state']} - ${data['pincode']}",
                        onEdit: () {
                          // Navigate to edit page later
                        },
                        onDelete: () async {
                          await FirebaseFirestore.instance
                              .collection('user')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('addresses')
                              .doc(docId)
                              .delete();
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddAddressPage(),
                      ),
                    );
                  },
                  child: _addNewAddressButton(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddressCard({
    required String label,
    required String name,
    required String phone,
    required String address,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.adressbaground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppColors.adressIcon,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              _actionButton(
                icon: Icons.edit_outlined,
                color: AppColors.categoryTitle,
                onTap: onEdit,
              ),

              const SizedBox(width: 8),

              _actionButton(
                icon: Icons.delete_outline,
                color: Colors.red,
                onTap: onDelete,
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                phone,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.home_outlined,
                size: 18,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: color,
        ),
      ),
    );
  }

  Widget _addNewAddressButton() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.categoryTitle,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.categoryTitle.withOpacity(.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_location_alt,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            "Add New Address",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 