
import 'package:ecommerce_fasion/features/profile/presentation/screens/adres_addingScreen.dart';
import 'package:flutter/material.dart';


class AddressPage extends StatelessWidget {
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();

  AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      floatingActionButton: FloatingActionButton(
        onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddressPage()));
        },
        child: Icon(Icons.add),
      ),
    );
     }
}
