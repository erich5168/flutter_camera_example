import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;

  ImageInput(this.onSelectImage);


  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if(imageFile == null){
      return;
    }

    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await sysPaths.getApplicationDocumentsDirectory();

    final fileName = path.basename(imageFile.path);
    print('${appDir.path}/$fileName');
    /// 291 ask the question:: if I delete this application does the image also get deleted,
    /// Could we access data/user/0/ to check if the image is really there?
    /// How would I move or save the image in the DIMC folder where we could access the image in the gallery
    ///data/user/0/com.example.sec13_map_api/app_flutter/scaled_ffd48c06-0844-4271-a86d-0c6de2e6aa98292674646141396969.jpg
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () => _takePicture(),
          ),
        ),
      ],
    );
  }
}
