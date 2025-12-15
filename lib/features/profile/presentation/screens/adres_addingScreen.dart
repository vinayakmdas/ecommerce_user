// lib/features/address/presentation/pages/add_address_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/profile/data/datasources/location_data_sources.dart';
import 'package:ecommerce_fasion/features/profile/domain/usecases/get_current_address.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/adress/adress_bloc.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/adress/adress_event.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/adress/adress_state.dart';
import 'package:ecommerce_fasion/features/profile/presentation/widget/adress_adding_widget.dart';
import '../../data/repositories/address_repository_impl.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController doorController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final  TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  late final AddressBloc addressBloc;

  @override
  void initState() {
    super.initState();

    final datasource = LocationDataSources();
    final repo = AddressRepositoryImpl(datasource);
    final usecase = GetCurrentAddress(repo);
    addressBloc = AddressBloc(getCurrentAddress: usecase);

    addressBloc.stream.listen((state) {
      if (state is AddressLoaded) {
        final addr = state.address;
        pincodeController.text = addr.pincode;
        streetController.text = addr.street;
        cityController.text = addr.city;
        stateController.text = addr.state;
        districtController.text=addr.district;
      } else if (state is AddressFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    doorController.dispose();
    pincodeController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    districtController.dispose();
    addressBloc.close();
    super.dispose();
  }

  void _onUseCurrentLocationPressed() {
    addressBloc.add(FetchCurrentAddress());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      appBar: AppBar(
        title: const Text('Add Address'),
        backgroundColor: AppColors.categoryTitle,
      ),
      body: BlocProvider.value(
        value: addressBloc,
        child: Stack(
          children: [
            _buildForm(),
            _buildLoader(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              const SizedBox(height: 12),
              AddressFormFields.fullName(fullNameController),
              const SizedBox(height: 12),
              AddressFormFields.phoneNumber(phoneController),
              const SizedBox(height: 12),
              AddressFormFields.houseFlatDoor(doorController),
              const SizedBox(height: 12),
              AddressFormFields.pincodeField(pincodeController),
              const SizedBox(height: 12),
              AddressFormFields.streetNameField(streetController),
              const SizedBox(height: 12),
              AddressFormFields.cityField(cityController),
              const SizedBox(height: 12),
              AddressFormFields.districtField(districtController),
              const SizedBox(height: 12,),
              AddressFormFields.stateField(stateController),
              const SizedBox(height: 20),
              AddressFormFields.currentLocationButton(
                _onUseCurrentLocationPressed,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width:  double.infinity,
                child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                                                     padding: const EdgeInsets.symmetric(vertical: 14),
                                                     backgroundColor: AppColors.errormessage,
                                                     shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                                                     ),
                                                   ), 
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save address
                    }
                  },
                  child: const Text('Save Address',style: TextStyle(color: AppColors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is AddressLoading) {
          return Container(
            color: Colors.black.withOpacity(0.25),
            child:  Center(
              child: CircularProgressIndicator(color: AppColors.errormessage,),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
