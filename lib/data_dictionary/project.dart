import 'dart:async';
import 'dart:collection';

import 'package:gobbetly/data_dictionary/data_object.dart';

class Project implements DataObject {
  static final String idLabel = 'id';
  static final String createdDateLabel = 'createdDate';
  static final String descriptionLabel = 'description';
  static final String statusLabel = 'status';
  static final String priorityLabel = 'priority';
  static final String startDateLabel = 'startDate';
  static final String lastUpdateDateLabel = 'lastUpdateDate';
  static final String completedDateLabel = 'completedDate';

  static final List<String> statusDescriptions = [
    'Open',
    'In Progress',
    'Complete'
  ];
  static final List<String> priorityValues = ['Normal', 'High', 'Very High'];

  Map<String, Object> _data;

  /// A Project is a group of tasks that achieve a useful goal. In general Tasks are grouped into a Project if it is pointless to do one of them without doing the rest of the tasks
  Project() {
    _data = new Map<String, Object>();

    _data[idLabel] = DataObject.getId();
    _data[createdDateLabel] = DateTime.now().toIso8601String();
    _data[lastUpdateDateLabel] =  _data[createdDateLabel];
  }

  Project.fromMap(Map<String, Object> m1) {
    _data = m1;
  }

  @override
  get map => _data;

  @override
  get id => _data[idLabel];

  @override
  get entityType => 'Project';

  /// a one line description of the project
  get description => _data[descriptionLabel];

  set description(String d) {
    if (d == null) {
      throw ProjectException('cannot set project description to null');
    }

    if (description != d) {
      _data[descriptionLabel] = d;
      setLastUpdate();
    }
  }

  /// the date time on which this project was first created
  get createdDate => DateTime.parse(_data[createdDateLabel]);

  /// the date time on which this project was last updated
  get lastUpdateDate => DateTime.parse(_data[lastUpdateDateLabel]);

  /// the date time on which this project was completed. Null if the project is not complete
  DateTime get completedDate {
    if (_data[completedDateLabel] == null) {
      return null;
    }
    return DateTime.parse(_data[completedDateLabel]);
  }

  /// the status of the project
  /// 0 or null - incomplete
  /// 2 - complete
  int get status {
    if (_data[statusLabel] == null) {
      return 0;
    }
    return _data[statusLabel];
  }

  set status(int st) {

    if (st == 0) {
      st = null;
    }

    if (st != null && st != 2) {
      throw ProjectException('invalid project status ' +
          st.toString() +
          ' for project ' +
          description);
    }



    if (_data[statusLabel] != st) {
      _data[statusLabel] = st;

      if (st == 2) {
        _data[completedDateLabel] = new DateTime.now().toIso8601String();
      } else {
        _data[completedDateLabel] = null;
      }

      setLastUpdate();
    }
  }

  /// the prioroty of the project
  /// 0 or null - normal
  /// 1 - high
  /// 2 - very high
  int get priority {
    if (_data[priorityLabel] == null) {
      return 0;
    }
    return _data[priorityLabel];
  }

  set priority(int pr) {
    if (pr < 0 || pr > 2) {
      throw Exception('invalid project priority ' +
          pr.toString() +
          ' for project ' +
          description);
    }

    if (priority != pr) {
      _data[priorityLabel] = pr;
      setLastUpdate();
    }
  }

  /// the earliest date on which any work on this project should be done
  DateTime get startDate {
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

    if (d != null) {
      if (d.millisecondsSinceEpoch != startDate.millisecondsSinceEpoch) {
        _data[startDateLabel] = d.toIso8601String();
        setLastUpdate();
      }
    }
  }

  setLastUpdate() {
    _data[lastUpdateDateLabel] = new DateTime.now().toIso8601String();
  }
}


/// Exception for data errors thrown by the [Project] class
class ProjectException implements Exception {

  String _message;

  ProjectException(this._message) {}

  String toString() => _message;
}
