import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/presentations/shared/customButton.dart';

import '../../shared/theme.dart';

class AddTypePage extends StatefulWidget {
  const AddTypePage({super.key});

  static const routeName = '/AddTypePage';

  @override
  State<AddTypePage> createState() => _AddTypePageState();
}

class _AddTypePageState extends State<AddTypePage> {
  List<String> imageLinks = [];
  List<XFile>? images;

  int i = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back",
          style: blackTextStyle,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Location Details",
                style: GoogleFonts.roboto().copyWith(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Text(
                "Add some types and provide detailed information.",
                style: GoogleFonts.roboto().copyWith(
                  fontSize: deviceWidth * 0.035,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Expanded(
                child: Center(
                  child: ListView.builder(
                    itemCount: i,
                    itemBuilder: (context, index) {
                      String k = "kik";

                      return Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.05,
                            vertical: deviceHeight * 0.01,
                          ),
                          child: Column(
                            children: <Widget>[
                              const TextField(
                                decoration: InputDecoration(
                                  hintText: "Nama Tipe",
                                ),
                              ),
                              const TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Harga",
                                ),
                              ),
                              const TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Kapasitas",
                                ),
                              ),
                              const TextField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: "Deskripsi",
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedImage =
                                      await picker.pickMultiImage();
                                  if (pickedImage.isNotEmpty) {
                                    setState(() {
                                      images = pickedImage;
                                    });
                                  }
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.all(10),
                                  width: deviceWidth * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 0.4),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset("assets/img/addImage.png",
                                          scale: 1.4),
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
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                            ),
                                            itemCount: images!.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.all(2),
                                                child: Image.file(
                                                  File(images![index].path),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      child: Text(k),
                                    ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Simpan"),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      i++;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                        .transparent), // Ganti warna latar belakang sesuai yang Anda inginkan
                  ),
                  child: const Text("Add More"),
                ),
              ),
              const CustomButton(name: "Next")
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _pickImages() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickMultiImage();
  //   if (pickedImage.isNotEmpty) {
  //     setState(() {
  //       images = pickedImage;
  //     });
  //   }
  // }
}
