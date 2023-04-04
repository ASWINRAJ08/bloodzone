import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'Splash_screen.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {

  final introKey = GlobalKey<IntroductionScreenState>();

    void _onIntroEnd(context) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const Splashscreen()),
      );
    }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
              key: introKey,
              globalBackgroundColor: Colors.white,
              allowImplicitScrolling: true,
              autoScrollDuration: 3000,
              pages: [
                    PageViewModel(
                      decoration: const PageDecoration(
                          bodyTextStyle: TextStyle(fontSize: 15),
                          titleTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 20
                          )
                      ),
                    title: "Donate Your Blood",
                    body: "Your generous donation can make a difference to millions of people in your own community.",
                    image: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Image.asset('Assets/Images/donor.png'),
                    ),
                      ),
                      PageViewModel(
                        decoration: const PageDecoration(
                            bodyTextStyle: TextStyle(
                                fontSize: 15),
                            titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 20
                            )
                        ),
                        title: "Post A Blood Request",
                        body: "Designed to help individuals in need of blood transfusions quickly and easily connect with potential donors in their area.",
                        image: Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Image.asset('Assets/Images/request.png',),
                        ),
                        ),
                PageViewModel(
                  decoration: const PageDecoration(
                      bodyTextStyle: TextStyle(fontSize: 15),
                      titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 20
                      )
                  ),
                  title: "Find Blood Donors",
                  body: "Making it easy to search for donors based on blood type, location, and availability.",
                  image: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Image.asset('Assets/Images/Find.png',),
                  ),
                ),
              ],
              onDone: () => _onIntroEnd(context),
              skipOrBackFlex: 0,
              nextFlex: 0,
              showSkipButton: true,
              skip: Text('Skip',style: TextStyle(color: Colors.pinkAccent[400]),),
              next: Icon(CupertinoIcons.arrow_right,color: Colors.pinkAccent[400],),
              done: Text("Let's Go",style: TextStyle(color: Colors.pinkAccent[400])),
              curve: Curves.fastLinearToSlowEaseIn,
              controlsMargin: const EdgeInsets.all(16),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                activeColor: Color(0xFFF50057),
                color: Color(0xFFFF80AB),
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            );
  }
}
