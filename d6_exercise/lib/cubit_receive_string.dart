import 'package:bloc/bloc.dart';

class CubitConvert extends Cubit<String>{
  CubitConvert() : super('a');

  void sizeIncrement(word) => emit(word.toUpperCase());
}