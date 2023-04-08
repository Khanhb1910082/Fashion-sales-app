import 'package:flutter/material.dart';

import '../../models/user.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail(this.user, {super.key});
  final Users user;
  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  var updateUser = Users(email: '', name: '', phone: '', address: '');
  @override
  void initState() {
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _addressController = TextEditingController(text: widget.user.address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật thông tin"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buidAvataField(width),
                const SizedBox(height: 10),
                _buildEmailField(),
                const SizedBox(height: 5),
                _buildAddressField(),
                const SizedBox(height: 5),
                _buildPhoneField(),
                const SizedBox(height: 10),
                _buildSubmitField(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      enabled: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email_rounded,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      cursorColor: Colors.pink,
      onSaved: (newValue) {
        updateUser = updateUser.copyWith(email: newValue);
      },
    );
  }

  _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.store_mall_directory,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: "Địa chỉ nhận hàng",
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.streetAddress,
      cursorColor: Colors.pink,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập địa chỉ nhận hàng.";
        } else if (value.length < 10) {
          return 'Địa chỉ giao hàng gồm đường, quận/huyện, tỉnh.';
        }
        return null;
      },
      onSaved: (newValue) {
        updateUser = updateUser.copyWith(address: newValue);
      },
    );
  }

  _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.phone,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: "Số điện thoại",
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.phone,
      cursorColor: Colors.pink,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập số điện thoại.";
        }
        if (value.length < 9 || value.length > 14) {
          return 'Số điện thoại không hợp lệ.';
        }
        return null;
      },
      onSaved: (newValue) {
        updateUser = updateUser.copyWith(phone: newValue);
      },
    );
  }

  _buildSubmitField() {
    return ElevatedButton(
      onPressed: () async {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        _formKey.currentState!.save();
        //await UserService.updateUser(updateUser);
        if (mounted) {
          Navigator.of(context).pop();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
      ),
      child: const Text(
        "Cập nhật",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buidAvataField(double width) {
    return InkWell(
      child: Container(
        width: width / 3.5,
        height: width / 3.5,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(width),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                height: width / 10,
                width: width / 3.5,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(width),
                        bottomRight: Radius.circular(width))),
                child: const Center(
                    child: Text(
                  "Sửa",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ))),
          ],
        ),
      ),
    );
  }
}
