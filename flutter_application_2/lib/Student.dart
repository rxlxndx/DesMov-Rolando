import 'package:flutter_application_2/Person.dart';

class Student extends Person{


  String enrollment;
  Student({name, required this.enrollment}) : super (name);
}