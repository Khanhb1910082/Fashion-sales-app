import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

var img_bg = const AssetImage("assets/images/background.png");

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool showpass = false;
  bool showrepass = false;
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
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                "Đăng ký",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 100, 1, 100),
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      hintText: 'Nhập họ tên',
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
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
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: 'Số điện thoại',
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
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
                                      obscureText: !showrepass,
                                      decoration: const InputDecoration(
                                          hintText: 'Nhập lại mật khẩu',
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                          ),
                                          border: InputBorder.none),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showrepass = !showrepass;
                                        });
                                      },
                                      child: SvgPicture(
                                        showrepass
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
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Text(
                                      "Đăng ký",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Center(
                              child: Row(
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
    );
  }
}
