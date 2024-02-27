import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/data/models/marker_model.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';

import '../bloc/image_bloc.dart';
import '../shared/theme.dart';

class EditMarkerPage extends StatefulWidget {
  const EditMarkerPage({super.key});
  static const routeName = "/EditMarkerPage";

  @override
  State<EditMarkerPage> createState() => _EditMarkerPageState();
}

class _EditMarkerPageState extends State<EditMarkerPage> {
  List<dynamic> imageList = [];
  late MarkerModel markerModel;

  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController socialMedia = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final arguments = ModalRoute.of(context)!.settings.arguments;

      if (arguments != null && arguments is MarkerModel) {
        setState(() {
          markerModel = arguments;
          imageList = arguments.image;

          name = TextEditingController(text: markerModel.name);
          contact = TextEditingController(text: markerModel.contact);
          address = TextEditingController(text: markerModel.address);
          socialMedia = TextEditingController(text: markerModel.socialMedia);
          price = TextEditingController(text: markerModel.harga);
          description = TextEditingController(text: markerModel.description);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(imageList);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Marker"),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<MarkersCubit>().updateMarkerUser(MarkerModel(
                  name: name.text,
                  description: description.text,
                  image: imageList,
                  jenis: markerModel.jenis,
                  userId: markerModel.userId,
                  latitude: markerModel.latitude,
                  longitude: markerModel.longitude,
                  contact: contact.text,
                  socialMedia: socialMedia.text,
                  address: address.text,
                  harga: price.text,
                  id: markerModel.id));
              DialogUtils.alertDialog(context, "Success", "Data Updated");
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              width: deviceWidth,
              height: deviceWidth * 0.6,
              child: PageView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return FadeInImage(
                    placeholder: const AssetImage("assets/gif/loading.gif"),
                    image: NetworkImage(imageList[index]),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedImage = await picker.pickMultiImage();

                    List<dynamic> urlLinks = await context
                        .read<ImageCubit>()
                        .uploadImageType(pickedImage);

                    urlLinks.forEach((element) {
                      setState(() {
                        imageList.add(element);
                      });
                    });
                  },
                  child: const Text("Add Image"),
                ),
              ),
            ),
            CustomtextFieldEdit(controller: name, label: "Name"),
            CustomtextFieldEdit(controller: address, label: "Address"),
            CustomtextFieldEdit(controller: price, label: "Price"),
            CustomtextFieldEdit(controller: socialMedia, label: "Social Media"),
            CustomtextFieldEdit(
              controller: description,
              label: "Description",
              isDesc: true,
            )
          ],
        ),
      ),
    );
  }
}

class CustomtextFieldEdit extends StatelessWidget {
  const CustomtextFieldEdit(
      {super.key,
      required this.controller,
      required this.label,
      this.isDesc = false});

  final TextEditingController controller;
  final String label;
  final bool isDesc;

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
        maxLines: isDesc ? 3 : 1,
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
