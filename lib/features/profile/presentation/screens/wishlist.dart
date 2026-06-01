import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "";
    final date = timestamp.toDate();
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
 
    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          "My Orders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
      ),
      body: userId == null
          ? const Center(child: Text("Please login to view orders"))
          : StreamBuilder<QuerySnapshot>(
          
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .where("userId",isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 70,
                          color: AppColors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "No orders placed yet",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final orders = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final orderDoc = orders[index];
                    final orderData = orderDoc.data() as Map<String, dynamic>;
                    final String displayId = orderData["paymentId"]?.toString() ?? orderDoc.id;
                    final String status = orderData["status"]?.toString() ?? "pending";
                    final Timestamp? createdAt = orderData["createdAt"] as Timestamp?;
                    final num amount = orderData["amount"] ?? orderData["totalAmount"] ?? 0;
                    final List<dynamic> items = orderData["items"] as List? ?? [];

                    // Setup status colors
                    Color statusBgColor = Colors.grey.shade100;
                    Color statusTextColor = Colors.grey.shade700;
                    if (status.toLowerCase() == "success" || status.toLowerCase() == "delivered") {
                      statusBgColor = Colors.green.shade50;
                      statusTextColor = Colors.green.shade800;
                    } else if (status.toLowerCase() == "not delivered" || status.toLowerCase() == "pending") {
                      statusBgColor = Colors.orange.shade50;
                      statusTextColor = Colors.orange.shade800;
                    }

                    return Card(
                      color: AppColors.white,
                      elevation: 2,
                      shadowColor: Colors.black12,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Order header (ID and Status)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    displayId.startsWith("#ORD-") ? displayId : "ID: ${displayId.substring(0, displayId.length.clamp(0, 10))}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusBgColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    status[0].toUpperCase() + status.substring(1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: statusTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _formatTimestamp(createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                            const Divider(height: 24),

                            // Items List inside Order
                            ...items.map<Widget>((item) {
                              final itemData = item as Map<String, dynamic>;
                              final String productName = itemData["productName"] ?? "Product";
                              final String imageUrl = itemData["image"] ?? "";
                              final num price = itemData["price"] ?? 0;
                              final int qty = itemData["qty"] ?? 1;
                              final String color = itemData["color"] ?? "";
                              final String size = itemData["size"] ?? "";

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) => Container(
                                                width: 50,
                                                height: 50,
                                                color: Colors.grey.shade100,
                                                child: const Icon(Icons.image_not_supported, size: 20),
                                              ),
                                            )
                                          : Container(
                                              width: 50,
                                              height: 50,
                                              color: Colors.grey.shade100,
                                              child: const Icon(Icons.image_not_supported, size: 20),
                                            ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                "₹ $price x $qty",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.appBar,
                                                ),
                                              ),
                                              if (color.isNotEmpty || size.isNotEmpty) ...[
                                                const SizedBox(width: 8),
                                                Text(
                                                  "(${color.isNotEmpty ? color : ''}${color.isNotEmpty && size.isNotEmpty ? ', ' : ''}${size.isNotEmpty ? size : ''})",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),

                            const Divider(height: 16),
                            // Order Total
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  "₹ $amount",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppColors.buyNow,
                                  ),
                                ),
                              ],
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