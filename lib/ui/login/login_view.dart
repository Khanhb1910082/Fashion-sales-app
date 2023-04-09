import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../register/register_view.dart';
import '../screens.dart';

var imgbg = const AssetImage("assets/images/background.png");

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool showpass = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 30),
                                child: Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              _buildEmailField(),
                              const SizedBox(height: 15),
                              _buildPasswordField(),
                              _buildForgotPass(),
                              _buildSubmitField(),
                              const SizedBox(height: 5),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "- Đăng nhập với -",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              _buildAnother(),
                              const SizedBox(height: 15),
                              _buildRegister(),
                            ],
                          ),
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
    );
  }

  _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email_rounded,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Email',
        hintStyle: const TextStyle(color: Colors.black12),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.pink,
      style: const TextStyle(fontSize: 18),
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập email.";
        }
        if (!value.contains('@') || value.length > 100) {
          return 'Sai định dạng email.';
        }
        return null;
      },
      onSaved: (newValue) {},
    );
  }

  _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.key_rounded,
          color: Colors.pink,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Mật khẩu',
        hintStyle: const TextStyle(color: Colors.black12),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        suffixIcon: _getIcon(),
      ),
      obscureText: showpass,
      cursorColor: Colors.pink,
      style: const TextStyle(fontSize: 18),
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
          showpass = !showpass;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture(
          showpass
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
      onPressed: _signIn,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
      ),
      child: const Text(
        "Đăng nhập",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Future<User?> _signIn() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )
          .then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomBar()));
      }).onError((error, stackTrace) {
        // ignore: avoid_print
        print(error.toString());
      });
      _formKey.currentState!.save();
    }
    return null;
  }

  _buildAnother() {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                )
              ],
            ),
            child: SvgPicture.asset(
              "assets/icons/google.svg",
              height: 30,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                )
              ],
            ),
            child: SvgPicture.asset(
              "assets/icons/facebook.svg",
              height: 37,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                )
              ],
            ),
            child: SvgPicture.asset(
              "assets/icons/phone-call.svg",
              height: 35,
            ),
          ),
        ),
      ],
    );
  }

  _buildRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Nếu bạn chưa có tài khoản? ",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterView()));
          },
          child: const Text(
            "Đăng ký ngay.",
            style: TextStyle(
              color: Color.fromARGB(255, 3, 15, 244),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _buildForgotPass() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text(
            "Quên mật khẩu?",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
