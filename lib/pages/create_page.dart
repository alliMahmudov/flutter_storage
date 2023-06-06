import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced/service/rtdb_service.dart';
import 'package:flutter_advanced/service/store_service.dart';
import 'package:image_picker/image_picker.dart';
import '../model/post_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var dateController = TextEditingController();
  var contentController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  _createPost() {
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String date = dateController.text.toString();
    String content = contentController.text.toString();

    if (firstname.isEmpty ||
        lastname.isEmpty ||
        date.isEmpty ||
        content.isEmpty) return;
    if (_image == null) return;

    _apiUploadImage(firstname, lastname, date, content);
  }

  _apiUploadImage(
      String firstname, String lastname, String date, String content) {
    setState(() {
      isLoading = true;
      StoreService.uploadImage(_image!).then((imgUrl) =>
          {_apiCreatePost(firstname, lastname, date, content, imgUrl)});
    });
  }

  _apiCreatePost(String firstname, String lastname, String date, String content,
      String imgUrl) {
    setState(() {
      isLoading = true;
    });
    var post = Post(
        firstname: firstname, lastname: lastname, date: date, content: content, imgUrl: imgUrl);
    RTDBService.addPost(post).then((value) => {
          _resAddPost(),
        });
  }

  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _getImage,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: _image != null
                          ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                          : Image.asset("assets/images/default.jpg"),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: firstnameController,
                    decoration: const InputDecoration(hintText: "Firstname"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: lastnameController,
                    decoration: const InputDecoration(hintText: "Lastname"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(hintText: "Date"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: contentController,
                    decoration: const InputDecoration(hintText: "Content"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                      onPressed: () {
                        _createPost();
                      },
                      color: Colors.red,
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
              isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      )
    );
  }
}
