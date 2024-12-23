import 'package:diary_app/DiaryPage/Page1/diary_screen_top.dart';
import 'package:diary_app/DiaryPage/Page1/profile_bar.dart';
import 'package:diary_app/DiaryPage/Page1/showAllEntries.dart';
import 'package:diary_app/DiaryPage/Page1/showEntryBox.dart';
import 'package:diary_app/Login_Signup/HomePage/homepage.dart';
import 'package:diary_app/globalData.dart';
import 'package:flutter/material.dart';

class HomeScreen1 extends StatefulWidget {
  HomeScreen1({super.key});
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  int isLoading = 0;
  String profileName = "Default";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    await FirebaseFirestoreService().getEntries();
    var userData = await FirebaseFirestoreService().getUserData();
    profileName = userData['name'];
    isLoading = isLoading + 1;
    setState(() {
    });
  }

  void mySetState()
  {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: isLoading != 1
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
        child: Column(
          children: [
            //profile
            ProfileBar(name: profileName),
            SizedBox(height: 10),

            //2 entries showed and when click in the box, show all entries
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2),spreadRadius: 2,blurRadius: 5,offset: Offset(0, 3),),],
                ),
                child: 
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                          child: Container(
                            height: 800, width: 700,
                            padding: EdgeInsets.all(20),
                            child: ShowAllEntries(superWidget: mySetState),
                          ),
                        );
                      },
                    );
                  },
                child: Container(
                  height: 265, width: 800,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Your last diary entries", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
                      SizedBox(height: 5),
                      (GlobalData.entriesSorted != null && GlobalData.entriesSorted.length >= 1) == true
                      ? DiaryScreen1(noteId: GlobalData.entriesSorted[0].key, title: GlobalData.entriesSorted[0].value['title'], dateTime: GlobalData.entriesSorted[0].value['last_update'], feeling: GlobalData.entriesSorted[0].value['feeling'], superState: mySetState)
                      : DiaryScreen1(superState: mySetState),
                      SizedBox(height: 5),
                      
                      (GlobalData.entriesSorted != null && GlobalData.entriesSorted.length >= 2) == true
                      ? DiaryScreen1(noteId: GlobalData.entriesSorted[1].key, title: GlobalData.entriesSorted[1].value['title'], dateTime: GlobalData.entriesSorted[1].value['last_update'], feeling: GlobalData.entriesSorted[1].value['feeling'], superState: mySetState)
                      : DiaryScreen1(superState: mySetState),
                    ],
                  ),
                ),
              ),
              ),
            ),

            SizedBox(height: 10),

            // All entries
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 900,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2),spreadRadius: 2,blurRadius: 5,offset: Offset(0, 3),),],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your ${GlobalData.entriesSorted == null ? "0" : GlobalData.entriesSorted.length} Entries",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent,),
                    ),
                    SizedBox(height: 10),
                    Container (
                        width: 900,
                        height: 300,
                        child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: GlobalData.feelingList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                GlobalData.getIcon(GlobalData.feelingList[index]),
                                SizedBox(width: 10,),
                                Text('${GlobalData.getPercentage(GlobalData.feelingList[index])}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              ],
                            )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {showEntryBox(context, mySetState, null, null);},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),),
                    child: Text("New Entry",style: TextStyle(fontSize: 16, color: Colors.black),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                            child: Container(height: 800, width: 700,padding: EdgeInsets.all(20),
                              child: ShowAllEntries(superWidget: mySetState,),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),),
                    child: Text("Show All Entries",style: TextStyle(fontSize: 16, color: Colors.black),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      );
  }
}

