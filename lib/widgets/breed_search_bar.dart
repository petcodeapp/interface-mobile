import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:petcode_app/services/breed_autocomplete_service.dart';
import 'package:petcode_app/utils/style_constants.dart';

class BreedSearchBar extends StatefulWidget {
  BreedSearchBar(
      {Key key,
      this.breedInputController,
      this.inputDecoration,
      this.species,
      this.breedValidator})
      : super(key: key);
  final TextEditingController breedInputController;
  final InputDecoration inputDecoration;
  final Species species;
  final FormFieldValidator<String> breedValidator;
  @override
  _BreedSearchBarState createState() => _BreedSearchBarState();
}

class _BreedSearchBarState extends State<BreedSearchBar> {
  BreedAutocompleteService _autocompleteService;

  @override
  void initState() {
    _autocompleteService = new BreedAutocompleteService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.breedInputController,
        decoration: widget.inputDecoration,
      ),
      onSuggestionSelected: (String breed) {
        widget.breedInputController.text = breed;
      },
      itemBuilder: (BuildContext context, String breed) {
        return ListTile(
          title: Text(breed, style: StyleConstants.editTextFieldText,),
          leading: Icon(Icons.pets),
        );
      },
      suggestionsCallback: (String breed) async {
        return await _autocompleteService.searchBreeds(breed, widget.species);
      },
      autoFlipDirection: true,
      hideOnEmpty: true,
      debounceDuration: Duration(milliseconds: 100),
      transitionBuilder: (BuildContext context, Widget suggestionsBox,
          AnimationController controller) {
        return suggestionsBox;
      },
      validator: widget.breedValidator,
    );
  }
}
