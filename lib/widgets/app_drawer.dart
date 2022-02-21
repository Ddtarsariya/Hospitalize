import 'package:flutter/material.dart';
import 'package:hospitalize/services/auth_service.dart';
import 'package:hospitalize/widgets/admin_wrapper.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context, listen: false);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: service.user == null
                      ? const Text('U')
                      : Text(service.user!.displayName.toString()[0]),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    service.user == null
                        ? const Text('Unknown')
                        : Text(service.user!.email.toString()),
                    const SizedBox(height: 5),
                    service.user == null
                        ? const Text('Unknown')
                        : Text(service.user!.displayName.toString()),
                  ],
                ),
              ),
            ),
            Divider(color: Theme.of(context).primaryColor),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AdminWrapper.routeName);
              },
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Admin'),
            ),
            const Divider(),
            ListTile(
              onTap: () async {
                await service.signOut(context: context);
              },
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
            ),
            const Divider(),
            const ListTile(
              title: Text(
                'v.1.0',
                style: TextStyle(color: Colors.black12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
