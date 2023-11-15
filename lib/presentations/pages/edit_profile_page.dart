import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/presentations/bloc/image_bloc.dart';
import 'package:wanderer/presentations/bloc/user_bloc.dart';

import 'package:wanderer/presentations/pages/tab_screen.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  static const routeName = '/editProfile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController name = TextEditingController();

  late TextEditingController email = TextEditingController();

  late TextEditingController number = TextEditingController();
  String link = "";
  XFile? images;
  late Users users;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        final arguments = ModalRoute.of(context)!.settings.arguments;
        if (arguments != null && arguments is Users) {
          setState(() {
            users = arguments;
            name = TextEditingController(text: users.username);
            email = TextEditingController(text: users.email);
            number = TextEditingController(text: users.telponNumber);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: blackTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (images != null) {
                List<String> links =
                    await context.read<ImageCubit>().uploadImageType([images!]);
                setState(() {
                  link = links[0];
                });
              }
              context.read<UserCubit>().updateUserData(UserModel(
                  username: name.text,
                  email: email.text,
                  imageUrl: link.isNotEmpty ? link : users.imageUrl,
                  telponNumber: number.text,
                  markers: users.markers,
                  role: users.role));
              Navigator.of(context).pushNamed(TabScreen.routeName);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: deviceHeight * 0.2,
              child: Stack(
                children: [
                  Positioned(
                    child: Center(
                      child: images != null
                          ? CircleAvatar(
                              backgroundImage: FileImage(File(images!.path)),
                              radius: 80,
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(users.imageUrl),
                              radius: 80,
                            ),
                    ),
                  ),
                  Positioned(
                    top: deviceHeight * 0.11,
                    left: deviceWidth * 0.6,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        _showHalfWidthPopup(context);
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        size: deviceWidth * 0.1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              users.username,
              style: GoogleFonts.roboto().copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.03,
            ),
            CustomtextField(
              controller: name,
              label: "Name",
            ),
            CustomtextField(
              controller: email,
              label: "Email",
            ),
            CustomtextField(
              controller: number,
              label: "Phone Number",
            )
          ],
        ),
      ),
    );
  }

  void _showHalfWidthPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Popup Setengah Lebar'),
          content: SizedBox(
            width: deviceWidth,
            // Setengah lebar layar
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {
                        images = pickedImage;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.all(10),
                    width: deviceWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.4),
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset("assets/img/addImage.png", scale: 1.4),
                        const Text("Tambah Foto"),
                      ],
                    ),
                  ),
                ),
                images != null
                    ? Center(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: deviceHeight * 0.1,
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              child: Image.file(
                                File(images!.path),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text("asd"),
                      ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}

class CustomtextField extends StatelessWidget {
  const CustomtextField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.01),
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), // Atur radius sudut di sini
        border: Border.all(color: Colors.grey), // Atur gaya garis tepi
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none, // Hapus garis tepi bawaan
          labelStyle: blackTextStyle,
        ),
      ),
    );
  }
}
