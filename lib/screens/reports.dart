import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:japamala/models/constants.dart';
import 'package:japamala/models/group.dart';
import 'package:japamala/models/userActivity.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:japamala/services/pdfService.dart';
import 'package:japamala/widgets/commonWidget.dart';
import 'package:japamala/widgets/pdfPreview.dart';
import 'package:japamala/widgets/progress.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  Future<QuerySnapshot> reportResultsFuture;
  Future<QuerySnapshot> activityResultsFuture;
  List<UserActivity> userActivityList;
  List<Group> groupList;
  String selectGroup;
  String selectDate;

  @override
  void initState() {
    super.initState();
    reportPageInitial();
  }

  genaratePDF() async {
    if (selectGroup != "" && selectDate != "") {
      // Group reportGroup =
      //groupList.firstWhere((grp) => grp.groupId == selectGroup);
      //print("groupId : ${reportGroup.groupId}");

      getActivityResults().then((_) => redirectToPDFPreview());
      //print("userActivity : ${userActivityList.length}");
    }
  }

  Future<void> getActivityResults() async {
    userActivityList = [];
    selectGroup = selectGroup.replaceAll("-", "");
    await userActivityRef
        // .where(Constants.groupId, isGreaterThanOrEqualTo: selectGroup)
        .get()
        .then((activity) {
      activity.docs.forEach((actItem) {
        if (actItem.id.contains(selectGroup)) {
          UserActivity userActivity = UserActivity.fromDocument(actItem);
          //userActivityList.add(userActivity);
          filterActivityResults(userActivity);
        }
      });
    });
  }

  filterActivityResults(UserActivity userActivity) {
    if (selectDate == "1") {
      String date1 = HelperFunctions.getDateFormat(
          dateTime: userActivity.dateTimeUA.toDate());
      String date2 = HelperFunctions.getDateFormat(dateTime: DateTime.now());
      if (date1 == date2) {
        userActivityList.add(userActivity);
      }
    } else if (selectDate == "2") {
      String date1 = HelperFunctions.getDateFormat(
          dateTime: userActivity.dateTimeUA.toDate());
      String date2 = HelperFunctions.getDateFormat(
          dateTime: DateTime.now().subtract(Duration(days: 1)));
      //print(date2);
      if (date1 == date2) {
        userActivityList.add(userActivity);
      }
    } else {
      userActivityList.add(userActivity);
    }
  }

  redirectToPDFPreview() async {
    if (userActivityList.length > 0) {
      PdfService pdf = new PdfService();
      String filePath = await pdf.generatePDF(userActivity: userActivityList);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PdfPreviewScreen(pdfPath: filePath)));
    }
  }

  reportPageInitial() {
    Future<QuerySnapshot> grp = groupRef
        .where(Constants.groupName, isGreaterThanOrEqualTo: '')
        .orderBy(Constants.groupName)
        .get();
    setState(() {
      reportResultsFuture = grp;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ReportDates> reportDates = [
      const ReportDates(id: '1', name: "Today"),
      const ReportDates(id: '2', name: "Yesterday"),
      const ReportDates(id: '3', name: "All Days"),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMain(
        context,
        title: "Reports",
      ),
      drawer: drawerMenu(context),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Day : ",
                    style: simpleTextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("Select Day"),
                        value: selectDate,
                        isDense: true,
                        onChanged: ((String newValue) {
                          setState(() {
                            selectDate = newValue;
                          });
                          //print("$selectDate");
                        }),
                        items: reportDates.map(
                          (ReportDates reportDates) {
                            return DropdownMenuItem<String>(
                              value: reportDates.id,
                              child: Text(
                                reportDates.name.toUpperCase(),
                                style: simpleTextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: reportResultsFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return circularProgress();
                  }
                  groupList = [];
                  snapshot.data.documents.forEach((doc) {
                    Group group = Group.fromDocument(doc);
                    groupList.add(group);
                    //print("group : ${group.groupId}");
                  });
                  return Row(
                    children: [
                      Text(
                        "Group : ",
                        style: simpleTextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("Select Group"),
                          value: selectGroup,
                          isDense: true,
                          onChanged: ((String newValue) {
                            setState(() {
                              selectGroup = newValue;
                            });
                            // print("$selectGroup");
                          }),
                          items: groupList.map(
                            (group) {
                              return DropdownMenuItem<String>(
                                value: group.groupId,
                                child: Text(
                                  group.groupName.toUpperCase(),
                                  style: simpleTextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  color: Colors.blueGrey,
                  onPressed: genaratePDF,
                  child: Text(
                    "Click here... for your Report",
                    style: simpleTextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add_chart,
      //   ),
      //   onPressed: genaratePDF,
      // ),
    );
  }
}

class ReportDates {
  final String id;
  final String name;
  const ReportDates({this.id, this.name});
}
