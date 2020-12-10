import 'package:flutter/material.dart';
import 'package:sqlite_train/helper/db_helper.dart';
import 'package:sqlite_train/model/course.dart';

import 'new_course.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite Database"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewCourse(),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: helper.allCourses(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Course course = Course.fromMap(snapshot.data[index]);
                  return ListTile(
                    title: Text(
                      '${course.name} - ${course.hours} hours',
                    ),
                    subtitle: Text(course.content),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        setState(() {
                          helper.delete(course.id);
                        });
                      },
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
