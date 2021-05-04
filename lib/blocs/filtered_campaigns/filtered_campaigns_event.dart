import 'package:equatable/equatable.dart';
import 'package:campaign_repository/campaign_repository.dart';
import 'package:nehemiah/models/models.dart';

abstract class FilteredCampaignsEvent extends Equatable {
  const FilteredCampaignsEvent();
}

class FilterUpdated extends FilteredCampaignsEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class CampaignsUpdated extends FilteredCampaignsEvent {
  final List<Campaign> campaigns;

  const CampaignsUpdated(this.campaigns);

  @override
  List<Object> get props => [campaigns];

  @override
  String toString() => 'CampaignsUpdated { campaigns: $campaigns }';
}
