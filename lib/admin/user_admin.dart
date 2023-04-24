import 'package:blackrose/admin/service/user_service.dart';
import 'package:blackrose/models/user.dart';
import 'package:flutter/material.dart';

import 'app_drawer.dart';

class UserAdmin extends StatefulWidget {
  const UserAdmin({super.key});

  @override
  State<UserAdmin> createState() => _UserAdminState();
}

class _UserAdminState extends State<UserAdmin> {
  int index = 1;
  var user = UserServiceAdmin.readUser();
  @override
  void initState() {
    user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thống kê"),
      ),
      drawer: const AppDrawer(),
      body: StreamBuilder(
          stream: user,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    border: TableBorder.all(color: Colors.black),
                    headingRowColor:
                        const MaterialStatePropertyAll(Colors.amberAccent),
                    columns: const [
                      DataColumn(label: Text('STT'), numeric: true),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('SĐT')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Address')),
                    ],
                    rows: user.map(_buildUser).toList(),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  DataRow _buildUser(Users user) {
    return DataRow(
      cells: [
        DataCell(Text('${index++}')),
        DataCell(Text(user.name)),
        DataCell(Text(user.phone)),
        DataCell(Text(user.email)),
        DataCell(Text(user.address)),
      ],
    );
  }
}
