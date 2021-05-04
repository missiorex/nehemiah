import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:campaign_repository/campaign_repository.dart';

typedef OnSaveCallback = Function(String title, String description);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Campaign campaign;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.campaign,
  }) : super(key: key ?? CampaignKeys.addCampaignScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;
  String _description;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = MainLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editCampaign : localizations.addCampaign,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.campaign.title : '',
                key: CampaignKeys.titleField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: localizations.newTodoHint,
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? localizations.emptyCampaignError
                      : null;
                },
                onSaved: (value) => _title = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.campaign.description : '',
                key: CampaignKeys.descriptionField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: localizations.descriptionHint,
                ),
                onSaved: (value) => _description = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing
            ? CampaignKeys.saveCampaignFab
            : CampaignKeys.saveNewCampaign,
        tooltip:
            isEditing ? localizations.saveChanges : localizations.addCampaign,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_title, _description);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
