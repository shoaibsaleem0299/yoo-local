import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/screens/cart/cart_view.dart';
import 'package:yoo_local/screens/home/home_view.dart';
import 'package:yoo_local/screens/settings/profile_settings.dart';
import 'package:yoo_local/screens/shipping_track/shipping_view.dart';
import 'package:yoo_local/screens/wishlists/wishlist_view.dart';

class GoogleNavBar extends StatefulWidget {
  const GoogleNavBar({super.key});

  @override
  State<GoogleNavBar> createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    ShippingView(),
    CartView(),
    HomeView(),
    WishlistView(),
    ProfileSettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        child: Container(
          color: AppColors.secondaryColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: GNav(
              backgroundColor: Colors.grey[900]!,
              color: Colors.white,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.white,
              gap: 8,
              padding: const EdgeInsets.all(12),
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
              tabs: const [
                GButton(
                  icon: Icons.local_shipping_outlined,
                  text: "Order",
                ),
                GButton(
                  icon: Icons.shopping_cart_checkout,
                  text: "Cart",
                ),
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.favorite,
                  text: "Wishlist",
                ),
                GButton(
                  icon: Icons.settings_suggest_outlined,
                  text: "Settings",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
