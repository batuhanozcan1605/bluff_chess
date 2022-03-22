import 'package:bluff_chess/rulebook_onboard/rulebook_export.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Rulebook extends StatefulWidget {
  const Rulebook({Key? key}) : super(key: key);

  @override
  _RulebookState createState() => _RulebookState();
}

class _RulebookState extends State<Rulebook> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenInfo = MediaQuery.of(context).size;
    final screenHeight = screenInfo.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: screenHeight/11.43),
        child: PageView(
          controller: controller,
          children: [
            const RulebookP1(),
            const RulebookP2(),
            const RulebookP3(),
            const RulebookP4(),
            const RulebookP5(),
            const RulebookP6(),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: screenHeight/11.43,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                controller.jumpToPage(5);
              },
              child: Text("SKIP", style: TextStyle(color: Color(0xFFA1887F)))),
            Center(
              child: SmoothPageIndicator(
                  controller: controller,  // PageController
                  count:  6,
                  effect: WormEffect(
                    spacing: 16,
                    dotColor: Color(0xFFEDE9D0),
                    activeDotColor: Color(0xFFA1887F),
                  ),  // your preferred effect
                  onDotClicked: (index){
                  }
              )
            ),
            IconButton(
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                  );
                },
                icon: Icon(Icons.keyboard_arrow_right)),
          ],
        ),
        ),
      );
  }
}

