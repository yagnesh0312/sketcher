import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketcher/models/helper.dart';
import 'package:sketcher/pages/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _controller = TextEditingController();
  final String subHead = "Let's Collaborate with";
  final String name = "Sketcher";
  final String joinBtnTxt = "Join";
  final String createBtnTxt = "Create Sketch";
  @override
  Widget build(BuildContext context) {
    bool isAndroid = MediaQuery.of(context).size.width < 1070;
    // print(MediaQuery.of(context).size.width);
    return Scaffold(
      // appBar: AppBar(title: Text(MediaQuery.of(context).size.width.toString()),),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1616904069743-d3a6c015467f?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              fit: BoxFit.cover),
          // gradient: LinearGradient(colors: [
          //   Color(0xff833ab4),
          //   Color(0xfffd1d1d),
          //   Color(0xfffcb045)
          // ]),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: BoxDecoration(
                // boxShadow: [BoxShadow(color: Colors.white30, blurRadius: 20)],
                // gradient: LinearGradient(colors: [
                //   Colors.blue.withOpacity(0.0),
                //   Colors.blue.withOpacity(0.4)
                // ]),
                // color: Colors.white,
                border: Border.all(
                    color: Colors.white12,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.hardEdge,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: isAndroid
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   height: 300,
                              //   decoration: BoxDecoration(),
                              //   child: Image.network(
                              //       "https://cdn3d.iconscout.com/3d/premium/thumb/painting-board-5748776-4817934.png?f=webp"),
                              // ),
                              Text(
                                subHead,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Color.fromARGB(188, 41, 252, 147),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                    height: 0.95,
                                    fontSize: 120,
                                    color: Color.fromARGB(255, 41, 252, 146),
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(30),
                                width: Get.width * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(81, 172, 255, 211)),
                                child: TextField(
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: _controller,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      fontSize: 50,
                                      letterSpacing: 10,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "00000"),
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  if (_controller.text.trim().isNum) {
                                    Get.to(
                                        () => HomePage(
                                            id: int.parse(
                                                _controller.text.trim())),
                                        transition: Transition.size,
                                        duration: const Duration(milliseconds: 900));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color.fromARGB(255, 0, 255, 132)),
                                  child: Text(
                                    joinBtnTxt,
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 500,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    )),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "OR",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    )),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () {
                                    Helper.CreateRoom();
                                  },
                                  child: Text(
                                    createBtnTxt,
                                    style: const TextStyle(fontSize: 40),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   height: 300,
                            //   decoration: BoxDecoration(),
                            //   child: Image.network(
                            //       "https://cdn3d.iconscout.com/3d/premium/thumb/painting-board-5748776-4817934.png?f=webp"),
                            // ),
                            Text(
                              subHead,
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(188, 41, 252, 147),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                  height: 0.95,
                                  fontSize: 120,
                                  color: Color.fromARGB(255, 41, 252, 146),
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                        const SizedBox(width: 40),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(30),
                              width: 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color.fromARGB(81, 172, 255, 211)),
                              child: TextField(
                                maxLength: 5,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: _controller,
                                cursorColor: Colors.white,
                                style: const TextStyle(
                                    fontSize: 50,
                                    letterSpacing: 10,
                                    color: Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "00000"),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                if (_controller.text.trim().isNum) {
                                  Get.to(
                                      () => HomePage(
                                          id: int.parse(
                                              _controller.text.trim())),
                                       transition: Transition.size,
                                      duration: const Duration(milliseconds: 600));
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color.fromARGB(255, 0, 255, 132)),
                                child: Text(
                                  joinBtnTxt,
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 500,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Container(
                                    color: Colors.grey,
                                    height: 1,
                                  )),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "OR",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    color: Colors.grey,
                                    height: 1,
                                  )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () {
                                  Helper.CreateRoom();
                                },
                                child: Text(
                                  createBtnTxt,
                                  style: const TextStyle(fontSize: 40),
                                )),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
