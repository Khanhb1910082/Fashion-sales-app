import 'package:blackrose/admin/order_admin.dart';
import 'package:blackrose/admin/statistical.dart';
import 'package:blackrose/admin/user_admin.dart';
import 'package:blackrose/ui/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('BlackRose'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(
              Icons.shop,
              color: Colors.deepOrange,
            ),
            title: const Text('Thống kê'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const StatisticalView()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.payment,
              color: Colors.deepOrange,
            ),
            title: const Text('Quản lý thành viên'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const UserAdmin()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.bookmark,
              color: Colors.deepOrange,
            ),
            title: const Text('Quản lý đơn hàng'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const OrderAdmin()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.deepOrange,
            ),
            title: const Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginView()),
                        (route) => false)
                  });
            },
          ),
        ],
      ),
    );
  }
}
