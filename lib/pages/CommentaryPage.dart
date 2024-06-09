// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project/pages/MainPage.dart';
import 'package:project/pages/ProblemPage.dart';

void main() {
  runApp(const MyApp());
}

// 비동기로 데이터베이스에서 문제 해설 내용을 가져오는 함수
Future<String> fetchProblemExplanation() async {
  // 데이터베이스나 API 호출로 데이터를 가져오는 부분
  await Future.delayed(const Duration(seconds: 1));
  const commentary = '이곳에 문제에 대한 해설이 기록될 거다.';
  return commentary;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProblemPage(),
    );
  }
}

class CommentaryPage extends StatelessWidget {
  final String selectedChoice;

  const CommentaryPage({super.key, required this.selectedChoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth * 0.8;
            double containerHeight = constraints.maxHeight * 0.65;

            return FutureBuilder<String>(
              future: fetchProblemExplanation(), // 비동기로 문제 해설 내용을 가져옴
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  String problemExplanation = snapshot.data!;
                  return Stack(
                    children: [
                      Center(
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: const Alignment(0, 0.3),
                            child: Container(
                              width: containerWidth,
                              height: containerHeight,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xFF4399FF),
                                  ),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 30),
                                    child: Container(
                                      width: containerWidth,
                                      height: containerHeight,
                                      decoration: ShapeDecoration(
                                        color: const Color.fromARGB(
                                            223, 234, 230, 230),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              selectedChoice, // 선택한 보기 내용 표시
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              width: 186,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          problemExplanation, // 문제에 대한 해설 표시
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        right: 50,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/img/backbtn.png',
                            width: 45,
                            height: 45,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 68,
                        left: 55,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/img/circle.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              '오늘의 학습',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text('No data');
                }
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/img/backbtn.png',
              width: 24,
              height: 24,
            ),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/img/homebtn.png',
              width: 28,
              height: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/img/mypagebtn.png',
              width: 24,
              height: 24,
            ),
            label: 'My Page',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
              break;
          }
        },
      ),
    );
  }
}
