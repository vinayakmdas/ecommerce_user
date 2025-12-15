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
      appBar: AppBar(
        title: Text('Saved Addresses'),
        centerTitle: true,
        backgroundColor: AppColors.categoryTitle,
        foregroundColor: AppColors.white,
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
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text("No addresses added yet"));
    }

    final addresses = snapshot.data!.docs;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: addresses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final data =
                    addresses[index].data() as Map<String, dynamic>;
                final docId = addresses[index].id;

                return _buildAddressCard(
                  label: "Address",
                  name: data['fullName'] ?? '',
                  phone: data['phone'] ?? '',
                  address:
                      "${data['door']}, ${data['street']}, ${data['city']}, ${data['district']}, ${data['state']} - ${data['pincode']}",
                  onEdit: () {
                    // Later: navigate to edit screen
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

          /// ➕ Add New Address Button (unchanged)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddAddressPage()),
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
Widget _addNewAddressButton() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.pink.shade50,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.location_on_outlined,
            color: Colors.pink.shade300,
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Add New Address',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        const Icon(Icons.add),
      ],
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.categoryTitle,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit_outlined, size: 20),
                color: Colors.grey.shade700,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete_outline, size: 20),
                color: Colors.red.shade400,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            phone,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            address,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}