import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/tipe.dart';
import '../../bloc/image_bloc.dart';
import '../../bloc/type_bloc.dart';
import '../../shared/theme.dart';

class ListTypeCard extends StatefulWidget {
  const ListTypeCard({super.key});

  @override
  State<ListTypeCard> createState() => _ListTypeCardState();
}

class _ListTypeCardState extends State<ListTypeCard> {
  List<XFile>? images;
  bool ready = false;

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                final pickedImage = await picker.pickMultiImage();
                if (pickedImage.isNotEmpty) {
                  setState(() {
                    images = pickedImage;
                  });
                }
                print("asdasds $images");
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
                : const Center(
                    child: Text("asd"),
                  ),
            BlocBuilder<ImageCubit, ImageState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(foregroundColor: baseColor),
                  onPressed: () async {
                    List<String> imageLinks = await context
                        .read<ImageCubit>()
                        .uploadImageType(images!);

                    print(imageLinks);

                    context.read<TypeCubit>().setType(
                          Tipe(
                            name: name.text,
                            price: double.parse(price.text),
                            facility: const [],
                            images: imageLinks,
                            capacity: int.parse(capacity.text),
                            description: description.text,
                            adminId: "",
                          ),
                        );
                  },
                  child: const Text("Simpan"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
