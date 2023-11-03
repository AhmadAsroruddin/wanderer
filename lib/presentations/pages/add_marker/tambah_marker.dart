import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/entities/location_data.dart';
import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/presentations/bloc/location_data_cubit.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/pages/add_marker/maps_page.dart';
import 'package:wanderer/presentations/pages/tab_screen.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../shared/button_add_marker.dart';
import '../../shared/utils.dart';

class AddMarkerPage extends StatefulWidget {
  const AddMarkerPage({super.key, required this.category});

  final String category;
  static const routeName = '/addMarkerPage';

  @override
  State<AddMarkerPage> createState() => _AddMarkerPageState();
}

class _AddMarkerPageState extends State<AddMarkerPage> {
  final TextEditingController address = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController description = TextEditingController();

  final TextEditingController socialMedia = TextEditingController();

  final TextEditingController contact = TextEditingController();

  final TextEditingController categoryController = TextEditingController();

  final TextEditingController harga = TextEditingController();

  LatLng latLngMarker = const LatLng(0, 0);
  List<XFile>? images;
  List<String> imageLinks = [];
  BuildContext? dContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Lokasi",
          style: blackTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Detail Lokasi",
                style: GoogleFonts.roboto().copyWith(fontSize: 16),
              ),
              Text(
                "Berikan beberapa informasi tentang tempat yang ingin di tambahkan",
                style: GoogleFonts.inter().copyWith(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              CustomTextFormFieldAddMarker(
                controller: name,
                hintText: "Nama Tempat (wajib)",
              ),
              CustomTextFormFieldAddMarker(
                hintText: widget.category,
                isCategory: false,
                controller: categoryController,
              ),
              CustomTextFormFieldAddMarker(
                controller: description,
                hintText: "Deskripsikan tentang tempat ini",
                maxLines: 5,
              ),
              Container(
                width: deviceWidth,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    width: 0.5,
                  ),
                ),
                child: BlocConsumer<LocationDataCubit, LocationDataa>(
                  listener: (context, state) {
                    setState(() {
                      address.value = TextEditingValue(text: state.alamat);
                      latLngMarker = state.latLng;
                    });
                  },
                  builder: (context, state) {
                    return Column(
                      children: <Widget>[
                        TextField(
                          controller: address,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                "SILAHKAN PILIH TITIK YANG SESUAI PADA PETA",
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(MapFullPage.routeName);
                          },
                          child: const Text("Pilih Di Peta"),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                "Kontak",
                style: GoogleFonts.roboto()
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w100),
              ),
              CustomTextFormFieldAddMarker(
                hintText: "Social Media",
                controller: socialMedia,
              ),
              CustomTextFormFieldAddMarker(
                hintText: "Kontak",
                controller: contact,
              ),
              CustomTextFormFieldAddMarker(
                hintText: "Harga",
                controller: harga,
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                "Tambah Foto",
                style: GoogleFonts.roboto()
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w100),
              ),
              GestureDetector(
                onTap: () {
                  _pickImages();
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
                          height: deviceHeight * 0.2,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: images!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.all(2),
                                  child: Image.file(File(images![index].path)));
                            },
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: const Text("Pilih Foto"),
                    ),
              BlocConsumer<MarkersCubit, MarkersState>(
                listener: (context, state) {
                  if (state is MarkersLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        dContext = context;
                        return const AlertDialog(
                          title: Text('Loading...'),
                          content: CircularProgressIndicator(),
                        );
                      },
                    );
                  } else if (state is MarkersFailed) {
                    Navigator.of(context).maybePop();
                    DialogUtils.alertDialog(
                        context, "Maaf Gagal :()", state.error);
                  } else if (state is MarkersSuccess) {
                    if (dContext != null) {
                      Navigator.pop(dContext!);
                    }
                    DialogUtils.alertDialog(context, "Berhasil", state.message);
                    Navigator.of(context).pushNamed(TabScreen.routeName);
                  }
                },
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ButtonAddWidget(
                        name: "Simpan",
                        red: 255,
                        green: 248,
                        blue: 248,
                        func: () {
                          final FirebaseAuth firebaseAuth =
                              FirebaseAuth.instance;
                          final String userId = firebaseAuth.currentUser!.uid;

                          context.read<MarkersCubit>().addMarkers(
                              Markers(
                                  name: name.text,
                                  description: description.text,
                                  image: imageLinks,
                                  jenis: widget.category,
                                  latitude: latLngMarker.latitude,
                                  longitude: latLngMarker.longitude,
                                  userId: userId,
                                  contact: contact.text,
                                  socialMedia: contact.text,
                                  address: address.text,
                                  harga: harga.text),
                              images!,
                              false,
                              []);
                        },
                      ),
                      ButtonAddWidget(
                        name: "Cancel",
                        red: 255,
                        green: 215,
                        blue: 0,
                        func: () async {
                          print("object");
                        },
                      ),
                    ],
                  );
                },
              ),
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

class CustomTextFormFieldAddMarker extends StatelessWidget {
  const CustomTextFormFieldAddMarker(
      {super.key,
      required this.hintText,
      this.isCategory = true,
      this.maxLines = 1,
      required this.controller});

  final String hintText;
  final bool isCategory;
  final int maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.015),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        enabled: isCategory,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: SafeGoogleFont(
            'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.2125,
            color: const Color(0xff636363),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}
