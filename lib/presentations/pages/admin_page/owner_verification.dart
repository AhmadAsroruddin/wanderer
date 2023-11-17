import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/entities/owner.dart';

import 'package:wanderer/presentations/pages/tab_screen.dart';
import 'package:wanderer/presentations/shared/customButton.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../bloc/admin_data_bloc.dart';
import '../../bloc/image_bloc.dart';

class OwnerVerification extends StatefulWidget {
  const OwnerVerification({super.key});
  static const routeName = '/ownerVerification';

  @override
  State<OwnerVerification> createState() => _OwnerVerificationState();
}

class _OwnerVerificationState extends State<OwnerVerification> {
  TextEditingController name = TextEditingController();
  TextEditingController nik = TextEditingController();
  XFile? _pickedImageKTP;
  XFile? _pickedImageKTPandPhoto;
  String ktp = "";
  String ktpandbody = "";

  Future<void> _getImage(bool ktpOnly) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (ktpOnly == true) {
      setState(() {
        _pickedImageKTP = pickedImage != null ? XFile(pickedImage.path) : null;
      });
    } else {
      setState(() {
        _pickedImageKTPandPhoto =
            pickedImage != null ? XFile(pickedImage.path) : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String adminId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Owner Verification",
          style: blackTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: deviceHeight * 0.01,
            horizontal: deviceWidth * 0.03,
          ),
          child: SingleChildScrollView(
            child: BlocConsumer<ImageCubit, ImageState>(
              listener: (context, state) {
                if (state is ImageSuccessKtp) {
                  print("KTP : ${state.links}");
                  setState(() {
                    ktp = state.links;
                  });
                } else if (state is ImageSuccessKtpandBody) {
                  print("KTP and Body : ${state.links}");
                  setState(() {
                    ktpandbody = state.links;
                  });
                }
              },
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    const Text(
                      "Please fill the data below correctly to confirm that you're Person-in-Charge . We only save your data, We will not use your data for irresponsible things",
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.05,
                    ),
                    InputTemp(
                      name: "Name",
                      controller: name,
                      hintText: "Name according to KTP",
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    InputTemp(
                      controller: nik,
                      name: "NIK",
                      hintText: "Write your NIK here",
                    ),
                    SizedBox(
                      height: deviceHeight * 0.04,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "KTP Photo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Upload your KTP Photo",
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _getImage(true);
                            await context
                                .read<ImageCubit>()
                                .uploadKtp(_pickedImageKTP!);
                          },
                          child: const Text('Pick Image'),
                        ),
                        SizedBox(height: deviceHeight * 0.01),
                        _pickedImageKTP != null
                            ? Image.file(
                                File(_pickedImageKTP!.path),
                                height: deviceHeight *
                                    0.2, // Sesuaikan dengan kebutuhan
                                width: deviceWidth *
                                    0.3, // Sesuaikan dengan kebutuhan
                              )
                            : Container(),
                      ],
                    ),
                    // INI UNTUK KTP DAN FOTO
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "KTP and Body Photo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Upload your photo by holding your KTP",
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _getImage(false);
                            await context
                                .read<ImageCubit>()
                                .uploadKtpandBody(_pickedImageKTPandPhoto!);
                          },
                          child: const Text('Pick Image'),
                        ),
                        SizedBox(height: deviceHeight * 0.01),
                        _pickedImageKTPandPhoto != null
                            ? Image.file(
                                File(_pickedImageKTPandPhoto!.path),
                                height: deviceHeight *
                                    0.2, // Sesuaikan dengan kebutuhan
                                width: deviceWidth *
                                    0.3, // Sesuaikan dengan kebutuhan
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.05,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Owner owner = Owner(
                            name: name.text,
                            nik: nik.text,
                            photoOnlyUrl: ktp,
                            photoWithBodyUrl: ktpandbody);
                        print(adminId);
                        await context
                            .read<AdminDataCubit>()
                            .addOwner(owner, adminId);
                        Navigator.of(context).pushNamed(TabScreen.routeName);
                      },
                      child: const CustomButton(
                        name: "Finish",
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class InputTemp extends StatelessWidget {
  const InputTemp({
    super.key,
    required this.controller,
    required this.name,
    required this.hintText,
  });

  final TextEditingController controller;
  final String name;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
