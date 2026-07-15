import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial(0));

  void changeIndex(int index) {
    emit(NavigationTabChanged(index));
  }
}
