import 'package:flutter/material.dart';
import 'package:sqlite_train/helper/db_helper.dart';
import 'package:sqlite_train/model/course.dart';

class CourseUpdate extends StatefulWidget {
  Course course;
  CourseUpdate(this.course);

  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  TextEditingController tcName = TextEditingController();
  TextEditingController tcContent = TextEditingController();
  TextEditingController tcHours = TextEditingController();
  TextEditingController tcLevel = TextEditingController();

  DbHelper helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    tcName.text = widget.course.name;
    tcContent.text = widget.course.content;
    tcHours.text = widget.course.hours.toString();
    tcLevel.text = widget.course.level;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Update"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextField(
              controller: tcName,
            ),
            TextField(
              controller: tcContent,
            ),
            TextField(
              controller: tcHours,
            ),
            TextField(
              controller: tcLevel,
            ),
            RaisedButton(
              onPressed: () {
                var updatedCourse = Course(
                  {
                    'id': widget.course.id,
                    'name': tcName.text,
                    'content': tcContent.text,
                    'hours': int.parse(tcHours.text),
                    'level': tcLevel.text,
                  },
                );
                helper.update(updatedCourse);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
