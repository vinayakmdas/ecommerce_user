import 'package:ecommerce_fasion/features/profile/presentation/widget/settings_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileCard(),

              const SizedBox(height: 24),

              _buildSectionTitle("Account"),

              _buildTile(
                icon: Icons.person_outline,
                title: "Edit Profile",
                iconBg: const Color(0xFFE3F2FD),
                iconColor: Colors.blue,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.location_on_outlined,
                title: "My Addresses",
                iconBg: const Color(0xFFE8F5E9),
                iconColor: Colors.green,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.credit_card_outlined,
                title: "Payment Methods",
                iconBg: const Color(0xFFFFF3E0),
                iconColor: Colors.orange,
                onTap: () {},
              ),

              const SizedBox(height: 16),

              _buildSectionTitle("Shopping"),

              _buildTile(
                icon: Icons.shopping_bag_outlined,
                title: "My Orders",
                iconBg: const Color(0xFFF3E5F5),
                iconColor: Colors.purple,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.favorite_border,
                title: "Wishlist",
                iconBg: const Color(0xFFFFF8E1),
                iconColor: Colors.amber,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.history,
                title: "Recently Viewed",
                iconBg: const Color(0xFFE0F7FA),
                iconColor: Colors.cyan,
                onTap: () {},
              ),

              const SizedBox(height: 16),

              _buildSectionTitle("Support"),

              _buildTile(
                icon: Icons.support_agent_outlined,
                title: "Help Center",
                iconBg: const Color(0xFFE8F5E9),
                iconColor: Colors.green,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.contact_support_outlined,
                title: "Contact Us",
                iconBg: const Color(0xFFE3F2FD),
                iconColor: Colors.blue,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.question_answer_outlined,
                title: "FAQs",
                iconBg: const Color(0xFFFFF3E0),
                iconColor: Colors.deepOrange,
                onTap: () {},
              ),

              const SizedBox(height: 16),

              _buildSectionTitle("Legal"),

              _buildTile(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy Policy",
                iconBg: const Color(0xFFE8F5E9),
                iconColor: Colors.green,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.description_outlined,
                title: "Terms & Conditions",
                iconBg: const Color(0xFFE3F2FD),
                iconColor: Colors.blue,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.assignment_return_outlined,
                title: "Refund Policy",
                iconBg: const Color(0xFFFFF3E0),
                iconColor: Colors.orange,
                onTap: () {},
              ),

              const SizedBox(height: 16),

              _buildSectionTitle("App Info"),

              _buildTile(
                icon: Icons.info_outline,
                title: "About App",
                iconBg: const Color(0xFFE0F7FA),
                iconColor: Colors.cyan,
                onTap: () {},
              ),

              _buildTile(
                icon: Icons.system_update_outlined,
                title: "Version 1.0.0",
                iconBg: const Color(0xFFF3E5F5),
                iconColor: Colors.purple,
                onTap: () {},
              ),

              const SizedBox(height: 16),

              _buildSectionTitle("Danger Zone"),

              _buildTile(
                icon: Icons.logout_rounded,
                title: "Logout",
                iconBg: Colors.orange.withOpacity(.15),
                iconColor: Colors.orange,
                onTap: () async {
                  await SettingsWidget.showLogoutDialog(context);
                },
              ),

              _buildTile(
                icon: Icons.delete_forever_outlined,
                title: "Delete Account",
                iconBg: Colors.red.withOpacity(.12),
                iconColor: Colors.red,
                onTap: () {},
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 34)),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vinayak",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text("vinayak@gmail.com", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.edit_outlined),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required Color iconBg,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ),
    );
  }
}
