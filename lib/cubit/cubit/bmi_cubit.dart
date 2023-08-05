import 'package:flutter_bloc/flutter_bloc.dart';

part 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit() : super(BmiInitial());

  void selectMale() {
    emit(GenderSelected(isMaleSelected: true, isFemaleSelected: false));
  }

  void selectFemale() {
    emit(GenderSelected(isMaleSelected: false, isFemaleSelected: true));
  }

  bool isDarkMode = true; // New state to track the app's mode


}
