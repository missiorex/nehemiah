import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:nehemiah/blocs/blocs.dart';
import 'package:nehemiah/screens/screens.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? CampaignKeys.campaignDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignsBloc, CampaignsState>(
      builder: (context, state) {
        final campaign = (state as CampaignsLoadSuccess)
            .campaigns
            .firstWhere((campaign) => campaign.id == id, orElse: () => null);
        final localizations = MainLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.campaignDetails),
            actions: [
              IconButton(
                tooltip: localizations.deleteCampaign,
                key: CampaignKeys.deleteCampaignButton,
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<CampaignsBloc>(context)
                      .add(CampaignDeleted(campaign));
                  Navigator.pop(context, campaign);
                },
              )
            ],
          ),
          body: campaign == null
              ? Container(key: CampaignKeys.emptyDetailsContainer)
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Checkbox(
                                key: CampaignKeys.detailsScreenCheckBox,
                                value: campaign.complete,
                                onChanged: (_) {
                                  BlocProvider.of<CampaignsBloc>(context).add(
                                    CampaignUpdated(
                                      campaign.copyWith(
                                          complete: !campaign.complete),
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${campaign.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      campaign.title,
                                      key:
                                          CampaignKeys.detailsCampaignItemTitle,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  campaign.description,
                                  key: CampaignKeys
                                      .detailsCampaignItemDescription,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: CampaignKeys.editCampaignFab,
            tooltip: localizations.editCampaign,
            child: Icon(Icons.edit),
            onPressed: campaign == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            key: CampaignKeys.editCampaignScreen,
                            onSave: (title, description) {
                              BlocProvider.of<CampaignsBloc>(context).add(
                                CampaignUpdated(
                                  campaign.copyWith(
                                      title: title, description: description),
                                ),
                              );
                            },
                            isEditing: true,
                            campaign: campaign,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
