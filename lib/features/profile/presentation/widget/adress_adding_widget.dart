// lib/features/address/presentation/widgets/address_form_fields.dart
import 'package:flutter/material.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';

class AddressFormFields {
  static Widget fullName(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Full Name",
        hintText: "Enter your full name",
        prefixIcon: Icon(Icons.person, color: AppColors.secondarybuttons),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter your full name";
        return null;
      },
    );
  }

  static Widget phoneNumber(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        prefixIcon: Icon(Icons.phone, color: AppColors.secondarybuttons),
        border: OutlineInputBorder(),
        counterText: "",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter phone number";
        if (value.length != 10) return "Phone number must be 10 digits";
        return null;
      },
    );
  }

  static Widget houseFlatDoor(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "House / Flat / Door No",
        hintText: "House / Flat / Door No",
        prefixIcon: Icon(Icons.home, color: AppColors.secondarybuttons),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter your house/flat/door number";
        return null;
      },
    );
  }

  static Widget pincodeField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: InputDecoration(
        labelText: "Pincode",
        hintText: "Enter Pincode",
        prefixIcon: Icon(Icons.pin_drop_outlined, color: AppColors.secondarybuttons),
        border: OutlineInputBorder(),
        counterText: "",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter your pincode";
        if (value.length != 6) return "Pincode must be 6 digits";
        return null;
      },
    );
  }

  static Widget streetNameField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Street Name",
        hintText: "Enter Street Name",
        prefixIcon: Icon(Icons.route_outlined, color: AppColors.secondarybuttons),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter your street name";
        return null;
      },
    );
  }

  static Widget cityField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Enter City",
        prefixIcon: Icon(Icons.location_city_outlined, color: AppColors.secondarybuttons),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter your city";
        return null;
      },
    );
  }
static Widget districtField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: "District",
      hintText: "Enter District",
      prefixIcon: Icon(
        Icons.map_outlined,
        color: AppColors.secondarybuttons,
      ),
      border: const OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your district";
      }
      return null;
    },
  );
}

  static Widget stateField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "State",
        hintText: "Enter State",
        prefixIcon: Icon(Icons.flag_outlined, color: AppColors.secondarybuttons),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter your state";
        return null;
      },
    );
  }

  // Current location card - pass onTap so page triggers Bloc
  static Widget currentLocationButton(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.white,
        child: ListTile(
          leading: CircleAvatar(
            minRadius: 28,
            maxRadius: 32,
            backgroundColor: const Color.fromARGB(255, 235, 176, 171),
            child: Icon(Icons.navigation_outlined, color: AppColors.buyNow),
          ),
          title: Text(
            "Use Current Location",
            style: TextStyle(
              color: AppColors.categoryTitle,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text("Get your GPS location automatically"),
        ),
      ),
    );
  }
}
