import 'package:diary_app/DiaryPage/Page1/showEntryBox.dart';
import 'package:diary_app/globalData.dart';
import 'package:flutter/material.dart';


//please provide or only isThereData = false -> empty
//else give dateTime, feeling and title
//return 3 things: Time, icon and title
// ignore: must_be_immutable
class DiaryScreen1 extends StatelessWidget {
  DiaryScreen1({
    Key? key,
    String? this.dateTime,
    String? this.feeling,
    String? this.title,
    String? this.noteId,
    required this.superState, 
  }) :  super(key: key);
  String? dateTime;
  String? feeling;
  String? title;
  String? noteId;

  VoidCallback superState;

  String formatDate(String date, String whatTime) {
    Map<String, String> res = {
    '01' : 'January',
    '02' : 'February',
    '03' : 'March',
    '04' : 'April',
    '05' : 'May',
    '06' : 'June',
    '07' : 'July',
    '08' : 'August',
    '09' : 'September',
    '10' : 'October',
    '11' : 'November',
    '12' : 'Dezember',
  };
    String day = date.substring(0,2);
    String? month = res[date.substring(3,5)];
    String year = date.substring(6,10);
    switch (whatTime)
    {
      case ('day'):
        return day;
      case ('month'):
        return month!;
      default:
        return (year);
    }
  }

  @override
  Widget build(BuildContext context) {
  if (title != null && title!.length > 44)
    title = title!.substring(0,40) + "...";
  return 
  GestureDetector(
    onTap: () {
      showEntryBox(context, superState, title, noteId);
      superState();
    },
    child: Container(
      height: 100,
      width: 750,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Colors.blueAccent.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            children: [
              Row(
                children: [
                  // Left Container
                  Container(
                    width: 135,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 67,
                          height: 65,
                          child: dateTime != null
                              ? Column(
                                  children: [
                                    Text(
                                      formatDate(dateTime!, 'day'),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      formatDate(dateTime!, 'month'),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      formatDate(dateTime!, 'year'),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Today',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                        ),
                        SizedBox(width: 10),
                        // Icon
                        feeling != null
                            ? GlobalData.getIcon(feeling!)
                            : GlobalData.getIcon('very_happy'),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  // Title
                  Expanded(
                    child: Text(
                      title != null ? title! : "Let's create a Note!",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
}


// ignore: must_be_immutable
class DiaryScreen2 extends StatelessWidget {
  DiaryScreen2({
    Key? key,
    required this.feeling,
    required this.title,
    required this.noteId,
    required this.superState, 
  }) :  super(key: key);
  String feeling;
  String title;
  String noteId;
  VoidCallback superState;

  @override
  Widget build(BuildContext context) {
  return 
  GestureDetector(
    onTap: () {
      showEntryBox(context, superState, title, noteId);
    },
    child: Container(
      height: 50,
      width: 800,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            children: [
              Row(
                children: [
                  GlobalData.getIcon(feeling),
                  SizedBox(width: 10),
                  Text(title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
}
