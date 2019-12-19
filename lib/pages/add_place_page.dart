import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';
import '../widgets/image_input.dart';

class AddPlacePage extends StatefulWidget {
  static const routeName = "/add-place";
  @override
  _AddPlacePageState createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final _titleController = TextEditingController();
  String inputValue;

  File _pickedImage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _submit() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatPlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);

    // Provider.of<GreatPlacesProvider>(context, listen: false)
    //     .addPlace(inputValue, _pickedImage);
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      // onChanged: (textInput) { 
                      //   inputValue = textInput; 
                      //   // print(inputValue);
                      //   print('Controller $_titleController');
                      // },
                      controller: _titleController,
                      // onSubmitted: (value) {
                      //   print('Value $value');
                      //   print('Controller $_titleController');
                      // },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0, // Get ride of drop shadow
            materialTapTargetSize: MaterialTapTargetSize
                .shrinkWrap, // Have the button set at the very bottom of the screen
            color: Theme.of(context).accentColor,

            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: () => _submit(),
          )
        ],
      ),
    );
  }
}
