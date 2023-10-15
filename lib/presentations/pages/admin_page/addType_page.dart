import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/entities/tipe.dart';
import 'package:wanderer/presentations/bloc/image_bloc.dart';
import 'package:wanderer/presentations/bloc/type_bloc.dart';
import 'package:wanderer/presentations/pages/tab_screen.dart';
import 'package:wanderer/presentations/shared/customButton.dart';

import '../../../data/models/admin_model.dart';
import '../../../domain/entities/marker.dart';
import '../../bloc/admin_bloc.dart';
import '../../bloc/markers_bloc.dart';
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

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController description = TextEditingController();

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
                              TextField(
                                controller: name,
                                decoration: const InputDecoration(
                                  hintText: "Nama Tipe",
                                ),
                              ),
                              TextField(
                                controller: price,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "Harga",
                                ),
                              ),
                              TextField(
                                controller: capacity,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "Kapasitas",
                                ),
                              ),
                              TextField(
                                controller: description,
                                maxLines: 3,
                                decoration: const InputDecoration(
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
                              BlocBuilder<ImageCubit, ImageState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<ImageCubit>()
                                          .upload(images!);
                                      if (state is ImageSuccess) {
                                        setState(() {
                                          imageLinks = state.links;
                                        });
                                      }
                                      context.read<TypeCubit>().setType(
                                            Tipe(
                                                name: name.text,
                                                price: double.parse(price.text),
                                                facility: [],
                                                images: imageLinks,
                                                capacity:
                                                    int.parse(capacity.text),
                                                description: description.text,
                                                adminId: ""),
                                          );
                                    },
                                    child: state is ImageLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text("Simpan"),
                                  );
                                },
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
              GestureDetector(
                  onTap: () async {
                    print("fired");

                    Navigator.of(context).pushNamed(TabScreen.routeName);
                  },
                  child: const CustomButton(name: "Next"))
            ],
          ),
        ),
      ),
    );
  }

  void addToFirestore() async {
    AdminModel admin = context.read<AdminCubit>().getAllAdmin();
    Markers marker = Markers(
        name: admin.name,
        description: admin.description,
        image: admin.image,
        jenis: admin.category,
        latitude: admin.latitude,
        longitude: admin.longitude,
        userId: "",
        contact: admin.noTelp,
        socialMedia: admin.instagram,
        address: admin.address,
        harga: "");
    context.read<MarkersCubit>().addMarkers(marker, images!, true);
    String adminId =
        await context.read<AdminCubit>().addToAdmin(admin.toEntity());

    List<Tipe> types = context.read<TypeCubit>().getTipe();
    context.read<TypeCubit>().addType(types, adminId);
  }
}
