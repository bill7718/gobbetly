
import 'package:gobbetly/data_dictionary/data_object.dart';
import 'package:gobbetly/data_dictionary/project.dart';
import 'package:test/test.dart';

void main() {
  test("test that new empty Project is correct", () {

    Project p = new Project();

    expect(p.id > 0, true);
    expect(p.description == null, true);
    expect(p.priority == 0, true);
    expect(p.status == 0, true);
    expect(p.completedDate == null, true);
    expect(p.createdDate == p.lastUpdateDate, true);

  });


  test("test initialise from a map", () {

    Project pFrom = new Project();

    Project p = new Project.fromMap(pFrom.map);

    expect(p.id > 0, true);
    expect(p.description == null, true);
    expect(p.priority == 0, true);
    expect(p.status == 0, true);
    expect(p.completedDate == null, true);
    expect(p.createdDate == p.lastUpdateDate, true);

  });

  test("get map", () {

    Project p = new Project();
    Map m = p.map;

    expect(m.toString().contains('createdDate:'), true);
    expect(m.toString().contains('id:'), true);

  });

  test("get id", () {

    int id = (DataObject.getId() ~/ 1000) * 1000;
    Project p = new Project();

    expect(p.id > id, true);
    expect(p.id < id + 1000, true);

  });


  test("get entity type is Project", () {

    Project p = new Project();
    expect(p.entityType == 'Project', true);

  });

  test("when I set a project description to null it throws an exception", () {

    Project p = new Project();
    try {
      p.description = null;
      expect(true, false);
    } catch (ex) {
      expect(ex.runtimeType.toString() == 'ProjectException', true);
      expect(ex.toString().contains('null'), true);
    }



  });

  test("when I set a project description I can get it", () {

    Project p = new Project();
    expect(p.description == 'test 0001', false);
    expect(p.createdDate == p.lastUpdateDate, true);
    // do this many times to ensure that it takes more the 1 millisecond
    int i = 0;
    while (i < 999) {
      p.description = i.toString();
      i++;
    }
    p.description = 'test 0001';
    expect(p.description == 'test 0001', true);
    expect(p.createdDate == p.lastUpdateDate, false);

  });

  test("when I set a project status to null it returns as 0", () {

    Project p = new Project();
    expect(p.status == 0, true);
    expect(p.createdDate == p.lastUpdateDate, true);
    p.status = null;
    expect(p.createdDate == p.lastUpdateDate, true);
    expect(p.status == 0, true);
  });

  test("when I set a project status to 0 it sets it as null - it does not update the completed date", () {

    Project p = new Project();
    expect(p.status == 0, true);
    expect(p.createdDate == p.lastUpdateDate, true);
    p.status = 0;
    expect(p.createdDate == p.lastUpdateDate, true);
    expect(p.status == 0, true);
    expect(p.completedDate == null, true);
  });


  test("when I set a project status to 2 it sets the completed date", () {

    Project p = new Project();
    expect(p.status == 0, true);
    expect(p.createdDate == p.lastUpdateDate, true);
    expect(p.completedDate == null, true);
    p.status = 2;
    expect(p.completedDate == null, false);
    expect(p.createdDate == p.lastUpdateDate, true);
    expect(p.status == 2, true);
  });

  test("when I set a project status to 1 it throws an exception", () {

    Project p = new Project();
    try {
      p.status  = 1;
      expect(true, false);
    } catch (ex) {
      expect(ex.runtimeType.toString() == 'ProjectException', true);
      expect(ex.toString().contains('status'), true);
    }
  });

  test("when I set a project status to 3 it throws an exception", () {

    Project p = new Project();
    try {
      p.status  = 3;
      expect(true, false);
    } catch (ex) {
      expect(ex.runtimeType.toString() == 'ProjectException', true);
      expect(ex.toString().contains('status'), true);
    }
  });

  test("when I set a project priority to null it returns as 0", () {

    Project p = new Project();
    expect(p.priority == 0, true);
    expect(p.createdDate == p.lastUpdateDate, true);
    p.priority = null;
    expect(p.createdDate == p.lastUpdateDate, true);
    expect(p.priority == 0, true);
  });

  test("when I set a project priority to 0 it sets it as null", () {

    Project p = new Project();
    expect(p.priority == 0, true);
    expect(p.createdDate == p.lastUpdateDate, true);
    p.priority = 0;
    expect(p.createdDate == p.lastUpdateDate, true);
    expect(p.priority == 0, true);
  });

  test("when I set a project priority to -1 it throws an exception", () {

    Project p = new Project();
    try {
      p.priority  = -1;
      expect(true, false);
    } catch (ex) {
      expect(ex.runtimeType.toString() == 'ProjectException', true);
      expect(ex.toString().contains('priority'), true);
    }
  });

  test("when I set a project priority to 3 it throws an exception", () {

    Project p = new Project();
    try {
      p.priority  = 3;
      expect(true, false);
    } catch (ex) {
      expect(ex.runtimeType.toString() == 'ProjectException', true);
      expect(ex.toString().contains('priority'), true);
    }
  });
}