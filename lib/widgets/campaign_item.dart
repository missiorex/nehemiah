import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:nehemiah/models/models.dart';
import 'package:campaign_repository/campaign_repository.dart';

class CampaignItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final GestureTapCallback onRosaryIncrement;
  final Campaign campaign;

  CampaignItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.campaign,
    @required this.onRosaryIncrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: CampaignKeys.campaignItem(campaign.id),
      onDismissed: onDismissed,
      child: ListTile(
          onTap: onTap,
          leading: Checkbox(
            key: CampaignKeys.campaignItemCheckbox(campaign.id),
            value: campaign.complete,
            onChanged: onCheckboxChanged,
          ),
          title: Hero(
            tag: '${campaign.id}__heroTag',
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                campaign.title,
                key: CampaignKeys.campaignItemTitle(campaign.id),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          subtitle: Row(
            children: [
              campaign.description.isNotEmpty
                  ? Text(
                      campaign.description,
                      key: CampaignKeys.campaignItemDescription(campaign.id),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : null,
              ElevatedButton(
                child: Icon(Icons.wb_sunny),
                onPressed: onRosaryIncrement,
              )
            ],
          )),
    );
  }
}
