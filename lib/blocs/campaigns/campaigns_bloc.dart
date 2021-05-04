import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'campaigns.dart';
import 'package:campaign_repository/campaign_repository.dart';

class CampaignsBloc extends Bloc<CampaignsEvent, CampaignsState> {
  final FirebaseCampaignRepository campaignsRepository;
  StreamSubscription _campaignsSubscription;

  CampaignsBloc({@required this.campaignsRepository})
      : super(CampaignsLoadInProgress());

  @override
  Stream<CampaignsState> mapEventToState(CampaignsEvent event) async* {
    if (event is CampaignsLoaded) {
      yield* _mapCampaignLoadedToState();
    } else if (event is CampaignsListened) {
      yield* _mapCampaignsUpdateToState(event);
    } else if (event is CampaignAdded) {
      yield* _mapCampaignAddedToState(event);
    } else if (event is CampaignUpdated) {
      yield* _mapCampaignUpdatedToState(event);
    } else if (event is CampaignDeleted) {
      yield* _mapCampaignDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

//  Stream<CampaignsState> _mapCampaignLoadedToState() async* {
//    try {
//      _campaignsSubscription?.cancel();
//      //final campaigns = await this.campaignsRepository.loadTodos();
//
//
//      _campaignsSubscription = campaignsRepository.campaigns().listen(
//            (campaigns) async* {
//              yield CampaignsLoadSuccess(
//                  campaigns.map(Campaign.fromEntity).toList(),
//              );
//        },
//      );
//
//
//
//
//    } catch (_) {
//      yield CampaignsLoadFailure();
//    }
//  }

//  Stream<CampaignsState> _mapCampaignLoadedToState() async* {
//    _campaignsSubscription?.cancel();
//
//    List<Campaign> _campaigns;
//    try {
//      _campaignsSubscription = campaignsRepository.campaigns().listen(
//        (campaigns) {
//          _campaigns = campaigns;
//        },
//      );
//      yield CampaignsLoadSuccess(_campaigns);
//    } catch (_) {
//      yield CampaignsLoadFailure();
//    }
//  }

  Stream<CampaignsState> _mapCampaignLoadedToState() async* {
    _campaignsSubscription?.cancel();

    try {
      _campaignsSubscription = campaignsRepository.campaigns().listen(
        (campaigns) {
          add(CampaignsListened(campaigns));
          print("campaigns loaded");
          //yield CampaignsLoadSuccess(campaigns);
        },
      );
    } catch (_) {
      yield CampaignsLoadFailure();
    }
  }

  Stream<CampaignsState> _mapCampaignAddedToState(CampaignAdded event) async* {
    if (state is CampaignsLoadSuccess) {
      final List<Campaign> updatedCampaigns =
          List.from((state as CampaignsLoadSuccess).campaigns)
            ..add(event.campaign);
      yield CampaignsLoadSuccess(updatedCampaigns);
      _addCampaign(event.campaign);
    }
  }

  Stream<CampaignsState> _mapCampaignUpdatedToState(
      CampaignUpdated event) async* {
    if (state is CampaignsLoadSuccess) {
      final List<Campaign> updatedCampaigns =
          (state as CampaignsLoadSuccess).campaigns.map((campaign) {
        return campaign.id == event.campaign.id ? event.campaign : campaign;
      }).toList();
      yield CampaignsLoadSuccess(updatedCampaigns);
      _saveCampaigns(updatedCampaigns);
    }
  }

  Stream<CampaignsState> _mapCampaignDeletedToState(
      CampaignDeleted event) async* {
    if (state is CampaignsLoadSuccess) {
      final updatedCampaigns = (state as CampaignsLoadSuccess)
          .campaigns
          .where((campaign) => campaign.id != event.campaign.id)
          .toList();
      yield CampaignsLoadSuccess(updatedCampaigns);
      _saveCampaigns(updatedCampaigns);
      _deleteCampaign(event.campaign);
    }
  }

  Stream<CampaignsState> _mapToggleAllToState() async* {
    if (state is CampaignsLoadSuccess) {
      final allComplete = (state as CampaignsLoadSuccess)
          .campaigns
          .every((campaign) => campaign.complete);
      final List<Campaign> updatedCampaigns = (state as CampaignsLoadSuccess)
          .campaigns
          .map((campaign) => campaign.copyWith(complete: !allComplete))
          .toList();
      yield CampaignsLoadSuccess(updatedCampaigns);
      _saveCampaigns(updatedCampaigns);
    }
  }

  Stream<CampaignsState> _mapClearCompletedToState() async* {
    if (state is CampaignsLoadSuccess) {
      final List<Campaign> updatedCampaigns = (state as CampaignsLoadSuccess)
          .campaigns
          .where((campaign) => !campaign.complete)
          .toList();
      yield CampaignsLoadSuccess(updatedCampaigns);
      _saveCampaigns(updatedCampaigns);
    }
  }

  Future _saveCampaigns(List<Campaign> campaigns) {
    return campaignsRepository.saveCampaigns(campaigns);
  }

  Future _addCampaign(Campaign campaign) {
    return campaignsRepository.addNewCampaign(campaign);
  }

  Future _deleteCampaign(Campaign campaign) {
    return campaignsRepository.deleteCampaign(campaign);
  }

  Stream<CampaignsState> _mapCampaignsUpdateToState(
      CampaignsListened event) async* {
    yield CampaignsLoadSuccess(event.campaigns);
  }
}
