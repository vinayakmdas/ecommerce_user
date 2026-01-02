import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/address_selection/address_selection_bloc.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/address_selection/address_selection_event.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/address_selection/address_selection_state.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/widget/checkout_Widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CheckoutScreens extends StatelessWidget {
  const CheckoutScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return BlocProvider(
      create: (_) => AddressSelectionBloc(),
      child: Scaffold(
        backgroundColor: AppColors.scafoldBaground,
        appBar: AppBar(
          backgroundColor: AppColors.appBar,
          elevation: 0,
          toolbarHeight: 80,
          title: const Text(
            "Checkout",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.white,
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
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No addresses added yet"));
            }

            final addresses = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// CONTACT INFO
                  CheckoutWidget.contactText(),
                  const SizedBox(height: 12),
                  CheckoutWidget.emailcontroller(emailController),

                  const SizedBox(height: 30),

                  /// ADDRESS HEADER
                  Row(
                    children: [
                      CheckoutWidget.savedAdressText(),
                      const Spacer(),
                      CheckoutWidget.elevatebutton(context),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ADDRESS LIST
                  Expanded(
                    child: BlocBuilder<AddressSelectionBloc,
                        AddressSelectionState>(
                      builder: (context, state) {
                        return ListView.separated(
                          itemCount: addresses.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final data = addresses[index].data()
                                as Map<String, dynamic>;
                            final docId = addresses[index].id;

                            final bool isSelected =
                                state.selectedAddressId == docId;

                            return CheckoutWidget.buildAddressCard(
                              isSelected: isSelected,
                              label: "Address",
                              name: data['fullName'] ?? '',
                              phone: data['phone'] ?? '',
                              address:
                                  "${data['door']}, ${data['street']}, ${data['city']}, "
                                  "${data['district']}, ${data['state']} - ${data['pincode']}",
                              onTap: () {
                                context.read<AddressSelectionBloc>().add(
                                      SelectAddressEvent(docId),
                                    );
                              },
                              onEdit: () {
                                // TODO: Navigate to edit address screen
                              },
                              onDelete: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.uid)
                                    .collection('addresses')
                                    .doc(docId)
                                    .delete();
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
