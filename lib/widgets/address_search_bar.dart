import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:petcode_app/models/Address.dart';
import 'package:petcode_app/services/address_autocomplete_service.dart';

class AddressSearchBar extends StatefulWidget {
  AddressSearchBar({Key key, this.addressController, this.inputDecoration})
      : super(key: key);
  final TextEditingController addressController;
  final InputDecoration inputDecoration;
  @override
  _AddressSearchBarState createState() => _AddressSearchBarState();
}

class _AddressSearchBarState extends State<AddressSearchBar> {
  AddressAutocompleteService _autocompleteService;

  @override
  void initState() {
    _autocompleteService = new AddressAutocompleteService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<Address>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.addressController,
        decoration: widget.inputDecoration,
      ),
      suggestionsCallback: (String address) async {
        return _autocompleteService.getLocationResults(address);
      },
      itemBuilder: (BuildContext context, Address suggestion) {
        return ListTile(
          leading: Icon(Icons.place),
          title: Text(suggestion.mainText),
          subtitle: Text(suggestion.secondaryText),
        );
      },
      onSuggestionSelected: (Address suggestion) {
        widget.addressController.text = suggestion.fullName;
      },
      autoFlipDirection: true,
      hideOnEmpty: true,
      debounceDuration: Duration(milliseconds: 100),
      transitionBuilder: (BuildContext context, Widget suggestionsBox,
          AnimationController animationController) {
        return suggestionsBox;
      },
    );
  }
}
