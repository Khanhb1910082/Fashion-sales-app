import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turtle_k/ui/home/bottom_bar.dart';
import 'package:turtle_k/ui/register/register_view.dart';

var img_bg = const AssetImage("assets/images/background.png");

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool showpass = false;
  @override
  Widget build(BuildContext context) {
    precacheImage(img_bg, context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: img_bg,
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
                        width: 400,
                        height: 250,
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
                              padding: EdgeInsets.only(top: 10, bottom: 30),
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 100, 1, 100),
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: [
                                    TextField(
                                      obscureText: !showpass,
                                      decoration: const InputDecoration(
                                          hintText: 'Mật khẩu',
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                          ),
                                          border: InputBorder.none),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showpass = !showpass;
                                        });
                                      },
                                      child: SvgPicture(
                                        showpass
                                            ? const SvgAssetLoader(
                                                "assets/icons/eye-open.svg")
                                            : const SvgAssetLoader(
                                                "assets/icons/eye-closed.svg"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
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
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Text(
                                        "Đăng nhập",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BottomBar()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text("- Đăng nhập với -"),
                            ),
                            Row(
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
                            ),
                            const SizedBox(height: 15),
                            Row(
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterView()));
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
                            ),
                          ],
                        ),
                      ),
                      //const SizedBox(height: 25),
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
}
