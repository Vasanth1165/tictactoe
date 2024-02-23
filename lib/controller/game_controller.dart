import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GameController extends GetxController{
  @override
  void onInit() {
    clear();
    super.onInit();
  }

  RxBool turn=false.obs;

  void turnSwap(){
    turn.value=!turn.value;
  }

  RxList<int> psList=[2,2,2,2,2,2,2,2,2].obs;

  RxInt numOfTaps=0.obs;

  RxList<List> winPostions=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]].obs;

  RxInt isWinner =2.obs;

  void checkGame(){
    for(int i=0;i<winPostions.length; i++){
      if(psList[winPostions[i][0]]==psList[winPostions[i][1]]
        && psList[winPostions[i][1]] ==psList[winPostions[i][2]]
        && psList[winPostions[i][0]]!=2
      ){
        turn.value==true ? isWinner.value=0 : isWinner.value=1;
      }
    }
  }

  void cliked(int index){
    if(psList[index]==0 || psList[index]==1){
      Get.snackbar("Warning", "postion is Occupied by ${turn.value==true ? "O" : "X" }",backgroundColor: Colors.red);
    }else{
      if(numOfTaps.value <=8){
        psList[index]=turn.value ? 1 : 0;
        numOfTaps.value++;
        turnSwap();
        checkGame();
        if(numOfTaps.value==9 && isWinner.value==2){
          Get.defaultDialog(
            title: "Tic Tac Toe",
            content: const Text("Draw"), 
            cancel: TextButton(onPressed: (){
              SystemNavigator.pop();
            }, child: const Text("Exit")),
            confirm: ElevatedButton(onPressed: (){
              clear();
              Get.back();
            }, child: const Text("Play Again"))
          );
        }else if(isWinner.value==1 || isWinner.value==0){
          Get.defaultDialog(
            titlePadding: const EdgeInsets.only(top: 12),
            title: "Tic Tac Toe",
            content:  Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    const Text("🎊 Winner 🎊",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 18,),
                    Image(image: turn.value ? const AssetImage("assets/zero.png") : const AssetImage("assets/cross.png"),height: 75,width: 75,),
                    const SizedBox(height: 12,),
                  ],
                ),
                Lottie.asset("assets/winner.json",height: 150,)
              ],
            ),
            cancel: TextButton(onPressed: (){
              SystemNavigator.pop();
            }, child: const Text("Exit")),
            confirm: ElevatedButton(onPressed: (){
              clear();
              Get.back();
            }, child: const Text("Play Again"))
          );
        }
      }else{
        Get.snackbar("Warning", "All postions filled",backgroundColor: Colors.red);
      }
    }
  }


  void clear(){
    psList.value=[2,2,2,2,2,2,2,2,2];
    isWinner.value=2;
    numOfTaps.value=0;
    turn.value=false;
  }
}