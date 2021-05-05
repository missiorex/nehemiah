import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:nehemiah/models/models.dart';
import 'package:campaign_repository/campaign_repository.dart';
import 'package:nehemiah/services/dynamic_link_service.dart';
import 'package:http/http.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class CampaignItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final GestureTapCallback onRosaryIncrement;
  final Campaign campaign;
  DynamicLinkService _service = DynamicLinkService();

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
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Icon(Icons.wb_sunny),
                    onPressed: onRosaryIncrement,
                  )),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Icon(Icons.share),
                    onPressed: (() async {
                      String shareCampaignImgUrl =
                          "https://firebasestorage.googleapis.com/v0/b/nehemiah-b1bea.appspot.com/o/default%2Fprayer_default.png?alt=media&token=55222858-52d4-4847-900d-47f98f1775b8";

                      Map parameters = {'id': campaign.id};

                      String campaignLink =
                          await _service.createLink(parameters, "campaign");

                      var request = await HttpClient()
                          .getUrl(Uri.parse(shareCampaignImgUrl));
                      var httpResponse = await request.close();
                      Uint8List bytes =
                          await consolidateHttpClientResponseBytes(
                              httpResponse);
                      WcFlutterShare.share(
                              sharePopupTitle: 'Share the love of Jesus',
                              subject: 'Please do join this prayer campaign',
                              text: campaignLink,
                              fileName: 'share.png',
                              mimeType: 'image/png',
                              bytesOfFile: bytes.buffer.asUint8List())
                          .then((value) {});
                    }),
                  )),
            ],
          )),
    );
  }
}
