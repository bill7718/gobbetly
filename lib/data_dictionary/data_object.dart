import 'dart:math';

/// defines hte properties common to all objects that are saved to the database
abstract class DataObject {

  static Random random = new Random();

  /// an integer id
  get id;

  /// a map of data items of which this object is comprised. The map should contain all the itens to be saved to the database and/or read from it
  get map;

  /// the type of data object that this object represents (e.g. Person, Task, Car)
  get entityType;


  /// returns a unique id which can be allocated to an object
  static int getId() {
    return (10000 * DateTime.now().millisecondsSinceEpoch) + random.nextInt(9999);
  }

}




