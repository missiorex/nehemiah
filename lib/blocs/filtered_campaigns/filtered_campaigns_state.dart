import 'package:equatable/equatable.dart';
import 'package:campaign_repository/campaign_repository.dart';
import 'package:nehemiah/models/models.dart';

abstract class FilteredCampaignsState extends Equatable {
  const FilteredCampaignsState();

  @override
  List<Object> get props => [];
}

class FilteredCampaignsLoadInProgress extends FilteredCampaignsState {}

class FilteredCampaignsLoadSuccess extends FilteredCampaignsState {
  final List<Campaign> filteredCampaigns;
  final VisibilityFilter activeFilter;

  const FilteredCampaignsLoadSuccess(
    this.filteredCampaigns,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredCampaigns, activeFilter];

  @override
  String toString() {
    return 'FilteredCampaignsLoadSuccess { filteredCampaigns: $filteredCampaigns, activeFilter: $activeFilter }';
  }
}
