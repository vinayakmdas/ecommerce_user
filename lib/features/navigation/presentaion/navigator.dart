import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/home/presentaion/homescreen.dart';
import 'package:ecommerce_fasion/features/navigation/bloc/imageIndex/select_index_bloc.dart';
import 'package:ecommerce_fasion/features/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int visit = 0;

  final List<TabItem> items = [
    const TabItem(icon: Icons.home, title: 'Home'),
    const TabItem(icon: Icons.search_outlined, title: 'Search'),
    const TabItem(icon: Icons.favorite_border, title: 'Favorite'),
    const TabItem(icon: Icons.shopping_cart_outlined, title: 'Cart'),
    const TabItem(icon: Icons.account_box, title: 'Profile'),
  ];

  final List<Widget> screens = const [
    HomeScreen(),
    Searchscreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => SelectIndexBloc(),
      child: BlocBuilder<SelectIndexBloc, int >(
        builder: (context, state) {
          return Scaffold(
            body: screens[state],
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 16, left: 16),
              child: BottomBarInspiredOutside(
                items: items,
                backgroundColor: AppColors.categoryTitle,
                color: Colors.white,
                colorSelected:  AppColors.categoryTitle,
                indexSelected: state,
                onTap: (int index) {
                  context.read<SelectIndexBloc>().changevalue(index);
                },
                chipStyle: const ChipStyle(
                  convexBridge: true,
                  background: Colors.white,
                ),
                animated: true,
                itemStyle: ItemStyle.hexagon, // 🟢 Animation style
              ),
            ),
          );
        },
      ),
    );
  }
}
