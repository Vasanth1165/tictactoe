import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controller/game_controller.dart';

class MyGameScreen extends StatefulWidget {
  const MyGameScreen({super.key});

  @override
  State<MyGameScreen> createState() => _MyGameScreenState();
}

class _MyGameScreenState extends State<MyGameScreen> {
  final gameController =Get.put(GameController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("${gameController.turn.value ? "X" : "O"}'s Turn",style: const TextStyle(fontSize: 24),)),
            Center(
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Obx(() => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: gameController.psList.length,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,mainAxisSpacing: 20,crossAxisSpacing: 20), 
                      itemBuilder:(context, index) {
                      return GestureDetector(
                      onTap: (){
                        gameController.cliked(index);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: gameController.psList[index]==0 
                            ? Image.asset("assets/zero.png").animate(delay: const Duration(microseconds: 50)).slideX()
                            : gameController.psList[index]==1 
                            ? Image.asset("assets/cross.png").animate(delay: const Duration(microseconds: 50)).slideX()
                            : const SizedBox(),
                        ),
                      ),
                    );
                  },),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}