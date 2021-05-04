import 'package:equatable/equatable.dart';
import 'package:campaign_repository/campaign_repository.dart';

abstract class CampaignsEvent extends Equatable {
  const CampaignsEvent();

  @override
  List<Object> get props => [];
}

class CampaignsLoaded extends CampaignsEvent {}

class CampaignsListened extends CampaignsEvent {
  final List<Campaign> campaigns;

  const CampaignsListened(this.campaigns);

  @override
  String toString() => 'Campaigns Listened { campaign: $campaigns }';

  @override
  List<Object> get props => [campaigns];
}

class CampaignAdded extends CampaignsEvent {
  final Campaign campaign;

  const CampaignAdded(this.campaign);

  @override
  List<Object> get props => [campaign];

  @override
  String toString() => 'CampaignAdded { campaign: $campaign }';
}

class CampaignUpdated extends CampaignsEvent {
  final Campaign campaign;

  const CampaignUpdated(this.campaign);

  @override
  List<Object> get props => [campaign];

  @override
  String toString() => 'CampaignUpdated { updatedCampaign: $campaign }';
}

class RosaryCountUpdated extends CampaignsEvent {
  final Campaign campaign;

  const RosaryCountUpdated(this.campaign);

  @override
  List<Object> get props => [campaign];

  @override
  String toString() => 'RosaryCountUpdated { updatedCampaign: $campaign }';
}

class CampaignDeleted extends CampaignsEvent {
  final Campaign campaign;

  const CampaignDeleted(this.campaign);

  @override
  List<Object> get props => [campaign];

  @override
  String toString() => 'CampaignDeleted { campaign: $campaign }';
}

class ClearCompleted extends CampaignsEvent {}

class ToggleAll extends CampaignsEvent {}
