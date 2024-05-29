import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final int _totalDots = 3;
  int _currentPosition = 0;

  int _validPosition(int position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1;
    return position;
  }

  void _updatePosition(int position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333d94),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("img/background.png"),
              fit: BoxFit.fill,
            )),
          ),
          _buildRow([
            DotsIndicator(
              dotsCount: _totalDots,
              position: _currentPosition,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              onTap: (pos) {
                setState(() => _currentPosition = pos);
              },
            )
          ]),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                  height: 80,
                  bottom: 80,
                  left: (MediaQuery.of(context).size.width - 200) / 2,
                  right: (MediaQuery.of(context).size.width - 200) / 2,
                  child: GestureDetector(
                      onTap: () {
                        // Navigator to AuthPage
                      },
                      child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFF7179ed),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Get Started',
                                style: TextStyle(color: Colors.white, fontSize: 26),
                              ),
                            ],
                          ))))
            ],
          ))
        ],
      ),
    );
  }
}