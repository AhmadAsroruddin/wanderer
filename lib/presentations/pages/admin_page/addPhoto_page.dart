import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/bloc/image_bloc.dart';
import 'package:wanderer/presentations/pages/admin_page/addType_page.dart';

import '../../shared/theme.dart';
import '../../shared/utils.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({super.key});
  static const routeName = '/addPhotoPage';

  @override
  State<AddPhotoPage> createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  List<XFile>? images;
  List<String> imageLinks = [];
  bool not = false;
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
                "Upload Photos",
                style: GoogleFonts.roboto().copyWith(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              const Text(
                "You can upload more than 1 photos, so choose your best photos",
              ),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              Container(
                width: deviceWidth * 0.9,
                height: deviceHeight * 0.07,
                padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.05,
                  vertical: deviceHeight * 0.015,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: <Widget>[
                    Image.asset("assets/img/tambah.png"),
                    SizedBox(
                      width: deviceWidth * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickImages();
                        setState(() {
                          not = true;
                        });
                      },
                      child: Text(
                        "Pick Photos",
                        style: TextStyle(fontSize: deviceWidth * 0.05),
                      ),
                    )
                  ],
                ),
              ),
              images != null
                  ? Center(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(top: deviceHeight * 0.03),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.7),
                          ),
                          height: deviceHeight * 0.4,
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
                      margin: EdgeInsets.only(
                        top: deviceHeight * 0.05,
                      ),
                      child: const Center(
                        child: Text(
                          "You haven't upload any photos yet",
                        ),
                      ),
                    ),
              SizedBox(
                height: deviceHeight * 0.1,
              ),
              BlocConsumer<ImageCubit, ImageState>(
                listener: (context, state) {
                  if (state is ImageFailed) {
                    print(state.error);
                  }
                },
                builder: (context, state) {
                  return not == false
                      ? Container(
                          width: double.infinity,
                          height: deviceHeight * 0.05,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(43, 255, 217, 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            await context.read<ImageCubit>().upload(images!);
                            if (state is ImageSuccess) {
                              imageLinks = state.links;
                              context.read<AdminCubit>().setImage(imageLinks);

                              Navigator.of(context)
                                  .pushNamed(AddTypePage.routeName);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: deviceHeight * 0.05,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 215, 0, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: state is ImageLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      "Next",
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2125,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                            ),
                          ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickMultiImage();
    if (pickedImage.isNotEmpty) {
      setState(() {
        images = pickedImage;
      });
    }
  }
}
