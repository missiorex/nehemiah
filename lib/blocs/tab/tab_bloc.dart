import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:nehemiah/blocs/tab/tab.dart';
import 'package:nehemiah/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.campaigns);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
