import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_train/model/course.dart';

class DbHelper {
  // create one used object when invoke
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();

  // the database
  static Database _db;

  // check null
  Future<Database> createDatabase() async {
    if (_db != null) _db;

    //define the path to the database
    String path = join(await getDatabasesPath(), 'school.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int v) {
        // create tables
        db.execute(
          'create table courses('
          'id integer primary key autoincrement,'
          'name varchar(50),'
          'content varchar(255),'
          'hours integer)',
        );
      },
    );
    return _db;
  }

  Future<int> CreateCourse(Course course) async {
    Database db = await createDatabase();
    return db.insert('courses', course.toMap());
  }

  Future<List> allCourses() async {
    Database db = await createDatabase();
    return db.query('courses');
  }

  Future<int> delete(int id) async {
    Database db = await createDatabase();
    return db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }
}
