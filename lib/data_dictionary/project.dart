import 'dart:async';
import 'dart:collection';


import 'package:gobbetly/data_dictionary/data_object.dart';

class Project  implements DataObject {
  static final String idLabel = 'id';
  static final String createdDateLabel = 'createdDate';
  static final String descriptionLabel = 'description';
  static final String statusLabel = 'status';
  static final String priorityLabel = 'priority';
  static final String startDateLabel = 'startDate';
  static final String lastUpdateDateLabel = 'lastUpdateDate';
  static final String completedDateLabel = 'completedDate';

  static final List<String> statusDescriptions = ['Open', 'In Progress', 'Complete'];
  static final List<String> priorityValues = ['Normal', 'High', 'Very High'];


  Map<String, Object> _data;

  /// A Project is a group of tasks that achieve a useful goal. In general Tasks are grouped into a Project if it is pointless to do one of them without doing the rest of the tasks
  Project() {
    _data = new Map<String, Object>();

    _data[idLabel] = DataObject.getId();
    _data[createdDateLabel] = DateTime.now().toIso8601String();
    _data[lastUpdateDateLabel] = new DateTime.now().toIso8601String();
  }

  Project.fromMap(Map<String, Object> m1) {
    _data = m1;
  }

  @override
  get map =>_data;

  @override
  get id =>_data[idLabel];

  /// a one line description of the project
  get description => _data[descriptionLabel];

  set description(String d) {
    if (d == null) {
      throw Exception('cannot set project description to null');
    }

    if (description != d) {
      _data[descriptionLabel] = d;
      setLastUpdate();
    }

  }

  /// the date time on which this project was first created
  get createdDate => DateTime.parse(_data[createdDateLabel]);
  get lastUpdateDate => DateTime.parse(_data[lastUpdateDateLabel]);
  DateTime get completedDate  {
    if (_data[completedDateLabel] == null) {
      return null;
    }
    return DateTime.parse(_data[completedDateLabel]);
  }

  /// the
  int get status => _data[statusLabel];
  set status(int st) {

    if (st != 0 && st != 2 ) {
      throw Exception(
          'invalid project status ' + st.toString() + ' for project ' + description);
    }


    if (status != st) {
      _data[statusLabel] = st;

      if (st == 'DONE') {
        _data[completedDateLabel] = new DateTime.now().toIso8601String();
      } else {
        _data[completedDateLabel] = null;
      }

      setLastUpdate();
    }
  }

  get priority => _data[priorityLabel];
  set priority(String pr) {
    if (pr == null) {
      throw Exception(
          'cannot set project priority to null for project ' + description);
    }

    if (!priorityValues.contains(pr)) {
      throw Exception(
          'invalid project priority ' + pr + ' for project ' + description);
    }

    if (priority != pr) {
      _data[priorityLabel] = pr;
      setLastUpdate();
    }
  }

  DateTime get startDate  {
    if (_data[startDateLabel] == null) {
      return null;
    }
    return DateTime.parse(_data[startDateLabel]);
  }
  set startDate(DateTime d) {

    if (d == null) {
      if (startDate != null) {
        _data[startDateLabel] = null;
        setLastUpdate();
      }
      return;
    }

    if (startDate == null) {
      DateTime ds = DateTime(d.year, d.month, d.day);
      _data[startDateLabel] = ds.toIso8601String();
      setLastUpdate();
      return;
    }

    if ((startDate.year != d.year || startDate.month != d.month || startDate.day != d.day) ) {
      DateTime ds = DateTime(d.year, d.month, d.day);
      _data[startDateLabel] = ds.toIso8601String();
      setLastUpdate();
    }
  }


  setLastUpdate() {
    _data[lastUpdateDateLabel] = new DateTime.now().toIso8601String();
  }



  @override
  get entityType => 'Project';
}
