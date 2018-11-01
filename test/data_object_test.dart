import 'package:gobbetly/data_dictionary/data_object.dart';
import 'package:test/test.dart';

void main() {
  test("test that getid returns unique numbers in ascending order", () {

    int id = DataObject.getId();
    int oldId = 0;



    int i = 0;
    while (i < 100) {

      oldId = id;
      id = DataObject.getId();



      expect(id >= (oldId - 1000), true);

      i++;
    }

  });


}