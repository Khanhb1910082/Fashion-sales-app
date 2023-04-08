import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/user.dart';
import '../login/login_view.dart';

var imgbg = const AssetImage("assets/images/background.png");

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool pass = true;
  bool repass = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  var user = Users(email: '', name: '', phone: '', address: '');
  @override
  Widget build(BuildContext context) {
    precacheImage(imgbg, context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imgbg,
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 205,
                          child: Image(
                            image: AssetImage("assets/logo/blackRose_logo.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          margin: const EdgeInsets.only(bottom: 25),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white30,
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              _buildNameField(),
                              const SizedBox(height: 10),
                              _buildEmailField(),
                              const SizedBox(height: 10),
                              // _buildPhoneField(),
                              // const SizedBox(height: 10),
                              _buildPasswordField(),
                              const SizedBox(height: 10),
                              _buildConfirmPasswordField(),
                              const SizedBox(height: 10),
                              _buildSubmitField(),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Nếu bạn đã có tài khoản? ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Đăng nhập.",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 3, 15, 244),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: "Tên người dùng",
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.name,
      cursorColor: Colors.pink,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập tên người dùng.";
        }
        if (value.length > 40) {
          return 'Tên người dùng không hợp lệ.';
        }
        return null;
      },
      onSaved: (newValue) {
        user = user.copyWith(name: newValue);
      },
    );
  }

  _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email_rounded,
          color: Colors.pink,
          size: 26,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Email',
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      style: const TextStyle(fontSize: 17),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.pink,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập email.";
        }
        if (!value.contains('@') || value.length > 100) {
          return 'Sai định dạng email.';
        }
        return null;
      },
      onSaved: (newValue) {
        user = user.copyWith(email: newValue);
      },
    );
  }

  // _buildPhoneField() {
  //   return TextFormField(
  //     controller: _phoneController,
  //     decoration: InputDecoration(
  //       prefixIcon: const Icon(
  //         Icons.phone,
  //         color: Colors.pink,
  //       ),
  //       fillColor: Colors.white,
  //       filled: true,
  //       hintText: "Số điện thoại",
  //       hintStyle: const TextStyle(color: Colors.black45),
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //           borderSide: BorderSide.none),
  //     ),
  //     keyboardType: TextInputType.phone,
  //     cursorColor: Colors.pink,
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         return "Vui lòng nhập số điện thoại.";
  //       }
  //       if (value.length < 9 || value.length > 14) {
  //         return 'Số điện thoại không hợp lệ.';
  //       }
  //       return null;
  //     },
  //     onSaved: (newValue) {
  //       user = user.copyWith(phone: newValue);
  //     },
  //   );
  // }

  _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.key_rounded,
          color: Colors.pink,
          size: 26,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Mật khẩu',
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        suffixIcon: _getIcon(),
      ),
      style: const TextStyle(fontSize: 17),
      obscureText: pass,
      cursorColor: Colors.pink,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập mật khẩu.';
        } else if (value.length < 5) {
          return 'Độ dài mật khẩu quá ngắn.';
        }
        return null;
      },
      onSaved: (newValue) {},
    );
  }

  _getIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          pass = !pass;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture(
          pass
              ? const SvgAssetLoader(
                  "assets/icons/eye-open.svg",
                )
              : const SvgAssetLoader("assets/icons/eye-closed.svg"),
          colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.srcIn),
        ),
      ),
    );
  }

  _buildSubmitField() {
    return ElevatedButton(
      onPressed: () async {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        _formKey.currentState!.save();
        FirebaseFirestore.instance
            .collection("users")
            .doc(_emailController.text)
            .set(user.toMap());
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Đăng ký thành công'),
            content: const Text(
                'Đăng nhập ngay để nhận ngay hàng ngàn sản phẩm được trợ giá'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginView())),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
      ),
      child: const Text(
        "Đăng ký",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  _buildConfirmPasswordField() {
    return TextFormField(
      controller: _repasswordController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.key_rounded,
          color: Colors.pink,
          size: 26,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Mật lại khẩu',
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      style: const TextStyle(fontSize: 17),
      obscureText: repass,
      cursorColor: Colors.pink,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập lại mật khẩu.';
        } else if (_passwordController.text != value) {
          return 'Mật khẩu không khớp.';
        }
        return null;
      },
      onSaved: (newValue) {},
    );
  }
}
