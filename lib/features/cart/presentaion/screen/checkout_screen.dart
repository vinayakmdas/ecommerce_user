import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/navigation/constants/app_Navigator.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/address_selection/address_selection_bloc.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/address_selection/address_selection_event.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/address_selection/address_selection_state.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/payment_method/payment_method_bloc.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/payment_method/payment_method_event.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/bloc/payment_method/payment_method_state.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/widget/checkout_Widget.dart';
import 'package:ecommerce_fasion/features/payment/presentation/screens/RazorpayScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreens extends StatelessWidget {
  final int amount;
  const CheckoutScreens({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return MultiBlocProvider(
      providers : [
        BlocProvider(create: (_) => AddressSelectionBloc()),
    BlocProvider(create: (_) => PaymentMethodBloc()),
      ],
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
           
                  CheckoutWidget.contactText(),
                  const SizedBox(height: 12),
                  CheckoutWidget.emailcontroller(emailController),

                  const SizedBox(height: 30),

             
                  Row(
                    children: [
                      CheckoutWidget.savedAdressText(),
                      const Spacer(),
                      CheckoutWidget.elevatebutton(context),
                    ],
                  ),

                  const SizedBox(height: 20),

              
                  Expanded(
                    child: BlocBuilder<AddressSelectionBloc, AddressSelectionState>(
                      builder: (context, state) {
                        return ListView.separated(
                          itemCount: addresses.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final data =
                                addresses[index].data() as Map<String, dynamic>;
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
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
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
                  const SizedBox(height: 20),

Text(
  "Payment Method",
  style: TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  ),
),

const SizedBox(height: 16),

BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
  builder: (context, paymentState) {
    return Column(
      children: [
        CheckoutWidget.paymentMethodCard(
          title: "Cash on Delivery",
          isSelected: paymentState.selectedMethod == "COD",
          onTap: () {
            context
                .read<PaymentMethodBloc>()
                .add(SelectPaymentMethod("COD"));
          },
        ),
        const SizedBox(height: 12),
        CheckoutWidget.paymentMethodCard(
          title: "UPI / Online Payment",
          isSelected: paymentState.selectedMethod == "UPI",
          onTap: () {
            context
                .read<PaymentMethodBloc>()
                .add(SelectPaymentMethod("UPI"));
          },
        ),
      ],
    );
  },
),
const SizedBox(height: 30),

BlocBuilder<AddressSelectionBloc, AddressSelectionState>(
  builder: (context, addressState) {
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
      builder: (context, paymentState) {
        final bool canProceed =
            addressState.selectedAddressId != null &&
            paymentState.selectedMethod != null;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: canProceed
                  ? AppColors.categoryTitle
                  : Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: canProceed
                ? () {
                    if (paymentState.selectedMethod == "COD") {
                      // COD FLOW (later order placing)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Order placed with COD"),
                        ),
                      );
                    } else {
                      // UPI → Razorpay Page
                     AppNavigator.push(
    context,
    RazorpayScreen(
      email:  emailController.text,
      amount: amount,
    ),
  );
                    }
                  }
                : null,
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        );
      },
    );
  },
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
