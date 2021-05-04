import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:nehemiah/blocs/blocs.dart';
import 'package:nehemiah/models/models.dart';
import 'package:nehemiah/blocs/blocs.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final CampaignsBloc campaignsBloc;
  StreamSubscription campaignsSubscription;

  StatsBloc({@required this.campaignsBloc}) : super(StatsLoadInProgress()) {
    void onCampaignsStateChanged(state) {
      if (state is CampaignsLoadSuccess) {
        add(StatsUpdated(state.campaigns));
      }
    }

    onCampaignsStateChanged(campaignsBloc.state);
    campaignsSubscription = campaignsBloc.listen(onCampaignsStateChanged);
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is StatsUpdated) {
      final numActive = event.campaigns
          .where((campaign) => !campaign.complete)
          .toList()
          .length;
      final numCompleted = event.campaigns
          .where((campaign) => campaign.complete)
          .toList()
          .length;
      yield StatsLoadSuccess(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    campaignsSubscription.cancel();
    return super.close();
  }
}
