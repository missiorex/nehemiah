import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:campaign_repository/campaign_repository.dart';
import 'package:nehemiah/models/models.dart';
import 'package:nehemiah/blocs/filtered_campaigns/filtered_campaigns.dart';
import 'package:nehemiah/blocs/campaigns/campaigns.dart';

class FilteredCampaignsBloc
    extends Bloc<FilteredCampaignsEvent, FilteredCampaignsState> {
  final CampaignsBloc campaignsBloc;
  StreamSubscription campaignsSubscription;

  FilteredCampaignsBloc({@required this.campaignsBloc})
      : super(
          campaignsBloc.state is CampaignsLoadSuccess
              ? FilteredCampaignsLoadSuccess(
                  (campaignsBloc.state as CampaignsLoadSuccess).campaigns,
                  VisibilityFilter.all,
                )
              : FilteredCampaignsLoadInProgress(),
        ) {
    campaignsSubscription = campaignsBloc.listen((state) {
      if (state is CampaignsLoadSuccess) {
        add(CampaignsUpdated(
            (campaignsBloc.state as CampaignsLoadSuccess).campaigns));
      }
    });
  }

  @override
  Stream<FilteredCampaignsState> mapEventToState(
      FilteredCampaignsEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is CampaignsUpdated) {
      yield* _mapCampaignsUpdatedToState(event);
    }
  }

  Stream<FilteredCampaignsState> _mapFilterUpdatedToState(
    FilterUpdated event,
  ) async* {
    if (campaignsBloc.state is CampaignsLoadSuccess) {
      yield FilteredCampaignsLoadSuccess(
        _mapCampaignsToFilteredCampaigns(
          (campaignsBloc.state as CampaignsLoadSuccess).campaigns,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredCampaignsState> _mapCampaignsUpdatedToState(
    CampaignsUpdated event,
  ) async* {
    final visibilityFilter = state is FilteredCampaignsLoadSuccess
        ? (state as FilteredCampaignsLoadSuccess).activeFilter
        : VisibilityFilter.all;
    yield FilteredCampaignsLoadSuccess(
      _mapCampaignsToFilteredCampaigns(
        (campaignsBloc.state as CampaignsLoadSuccess).campaigns,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Campaign> _mapCampaignsToFilteredCampaigns(
      List<Campaign> campaigns, VisibilityFilter filter) {
    return campaigns.where((campaign) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !campaign.complete;
      } else {
        return campaign.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    campaignsSubscription.cancel();
    return super.close();
  }
}
