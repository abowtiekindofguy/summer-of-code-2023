import 'package:flutter/material.dart';
import 'package:my_app/api.dart';
import 'api.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'cloud_local_storage.dart';
import 'dart:io';

class PostProductForm extends StatefulWidget {
  const PostProductForm({Key? key}) : super(key: key);
  @override
  _PostProductFormState createState() => _PostProductFormState();
}

class _PostProductFormState extends State<PostProductForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  double _price = 0.0;
  String _location = '';
  String _category = '';
  String _img_url = '';
  bool _isNegotiable = false;
  File? _imageFile;
  String? _imagePath;

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _imagePath = image.path;
      });
      print(_imagePath);
    }
  }

  Future<String> _uploadImageToFirebase() async {
    dynamic _storage = firebase_storage.FirebaseStorage.instance;

    dynamic reference = _storage.ref().child("images/");
    dynamic uploadTask = reference.putFile(_imageFile);
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty';
                  }
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty';
                  }
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty';
                  }
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty';
                  }
                },
                onSaved: (value) {
                  _location = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty';
                  }
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty';
                  }
                },
                onSaved: (value) {
                  _img_url = value!;
                },
              ),
              SwitchListTile(
                title: Text('Is the Price Negotiable?'),
                value: _isNegotiable,
                onChanged: (value) {
                  setState(() {
                    _isNegotiable = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _getImageFromCamera,
                child: Text('Select Image'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_imageFile != null) {
                      final imageUrl = await _uploadImageToFirebase();
                      print('Image URL: $imageUrl');
                      Map<String, dynamic> formData = {
                        'title': _title,
                        'category': _category,
                        'price': _price,
                        'location': _location,
                        'description': _description,
                        'img_url': imageUrl,
                        "metadata_user": "string",
                        'isNegotiable': _isNegotiable,
                        "isFeatured": true,
                        "isPromoted": true
                      };
                      postData(formData);
                    } else {
                      print('no image');
                    }
                  }
                },
                child: Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
