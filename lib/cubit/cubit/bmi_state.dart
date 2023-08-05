part of 'bmi_cubit.dart';

abstract class BmiState {}

class BmiInitial extends BmiState {}

// Selected Gender
class GenderSelected extends BmiState {
  final bool isMaleSelected;
  final bool isFemaleSelected;

  GenderSelected({
    required this.isMaleSelected,
    required this.isFemaleSelected,
  });
}


