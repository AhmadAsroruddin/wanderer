import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/data/models/admin_model.dart';
import 'package:wanderer/data/models/tipe_model.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/presentations/bloc/admin_data_bloc.dart';

import 'package:wanderer/presentations/bloc/image_bloc.dart';
import 'package:wanderer/presentations/bloc/type_bloc.dart';
import 'package:wanderer/presentations/shared/alertDialog.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class AdminEditPage extends StatefulWidget {
  const AdminEditPage({super.key});

  static const routeName = "/AdminEditPage";
  @override
  State<AdminEditPage> createState() => _AdminEditPageState();
}

class _AdminEditPageState extends State<AdminEditPage> {
  late List<dynamic> imageList = [];
  List<dynamic> imageListType = [];
  late Admin admin;
  late Type type;

  TextEditingController name = TextEditingController();
  TextEditingController noRek = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController noTelp = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController tiktok = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController nameRek = TextEditingController();
  TextEditingController aliasNameRek = TextEditingController();
  TextEditingController emailRek = TextEditingController();
  TextEditingController bankRek = TextEditingController();

  TextEditingController nameType = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController descriptionType = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        final arguments = ModalRoute.of(context)!.settings.arguments;
        if (arguments != null && arguments is Admin) {
          context.read<TypeCubitData>().getType(arguments.id);
          setState(() {
            admin = arguments;

            imageList = admin.image;
            name = TextEditingController(text: admin.name);
            email = TextEditingController(text: admin.email);
            noTelp = TextEditingController(text: admin.noTelp);
            tiktok = TextEditingController(text: admin.tiktok);
            instagram = TextEditingController(text: admin.instagram);
            time = TextEditingController(text: admin.time);
            description = TextEditingController(text: admin.description);
            bankRek = TextEditingController(text: admin.bankRek);
            noRek = TextEditingController(text: admin.noRek);
            aliasNameRek = TextEditingController(text: admin.aliasNameRek);
            emailRek = TextEditingController(text: admin.emailRek);
          });
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("this is $imageList");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        actions: [
          IconButton(
            onPressed: () async {
              context.read<AdminDataCubit>().updateData(AdminModel(
                  name: name.text,
                  id: admin.id,
                  userId: admin.userId,
                  noRek: noRek.text,
                  address: admin.address,
                  email: email.text,
                  image: imageList,
                  noTelp: noTelp.text,
                  instagram: instagram.text,
                  tiktok: tiktok.text,
                  website: website.text,
                  facilities: admin.facilities,
                  time: time.text,
                  markerId: admin.markerId,
                  description: description.text,
                  latitude: admin.latitude,
                  longitude: admin.longitude,
                  category: admin.category,
                  nameRek: nameRek.text,
                  aliasNameRek: aliasNameRek.text,
                  bankRek: bankRek.text,
                  emailRek: emailRek.text));
              DialogUtils.alertDialog(
                  context, "Success", "Data update successfully");
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                height: deviceHeight * 0.02,
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
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              SizedBox(
                child: Text(
                  "YOUR PROFILE",
                  style: blackTextStyle.copyWith(
                      fontWeight: bold, fontSize: deviceWidth * 0.04),
                ),
              ),
              CustomtextFieldEdit(
                controller: name,
                label: "name",
              ),
              CustomtextFieldEdit(
                controller: email,
                label: "email",
              ),
              CustomtextFieldEdit(
                controller: noTelp,
                label: "Nomor Telepon",
              ),
              CustomtextFieldEdit(
                controller: website,
                label: "Website",
              ),
              CustomtextFieldEdit(
                controller: tiktok,
                label: "Tiktok",
              ),
              CustomtextFieldEdit(
                controller: instagram,
                label: "Instagram",
              ),
              CustomtextFieldEdit(
                controller: time,
                label: "Time",
              ),
              CustomtextFieldEdit(
                controller: noTelp,
                label: "Description",
                isDesc: true,
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              SizedBox(
                child: Text(
                  "BANK ACCOUNT",
                  style: blackTextStyle.copyWith(
                      fontWeight: bold, fontSize: deviceWidth * 0.04),
                ),
              ),
              CustomtextFieldEdit(
                label: "Account Name",
                controller: bankRek,
              ),
              CustomtextFieldEdit(
                  controller: aliasNameRek, label: "Alias Name"),
              CustomtextFieldEdit(controller: noRek, label: "Account Number"),
              CustomtextFieldEdit(label: "Email", controller: email),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              SizedBox(
                child: Text(
                  "TYPE LIST",
                  style: blackTextStyle.copyWith(
                      fontWeight: bold, fontSize: deviceWidth * 0.04),
                ),
              ),
              Container(
                height: deviceHeight * 0.5,
                width: deviceWidth,
                child: BlocBuilder<TypeCubitData, TypeDataState>(
                  builder: (context, state) {
                    if (state is TypeDataSuccessState) {
                      return ListView.builder(
                          itemCount: state.tipe.length,
                          itemBuilder: (context, index) {
                            imageListType = state.tipe[index].images;
                            nameType = TextEditingController(
                                text: state.tipe[index].name);
                            capacity = TextEditingController(
                                text: state.tipe[index].capacity.toString());
                            descriptionType = TextEditingController(
                                text: state.tipe[index].description);
                            price = TextEditingController(
                                text: state.tipe[index].price.toString());

                            return Padding(
                              padding: EdgeInsets.all(deviceWidth * 0.03),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    state.tipe[index].name,
                                    style: blackTextStyle.copyWith(
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Container(
                                    width: deviceWidth * 0.4,
                                    height: deviceHeight * 0.2,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                    ),
                                    child: PageView.builder(
                                      itemCount: imageListType.length,
                                      itemBuilder: (context, indexs) {
                                        return FadeInImage(
                                          placeholder: const AssetImage(
                                              "assets/gif/loading.gif"),
                                          image: NetworkImage(
                                            imageListType[indexs],
                                          ),
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: deviceWidth * 0.02),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final picker = ImagePicker();
                                        final pickedImage =
                                            await picker.pickMultiImage();

                                        List<dynamic> urlLinks = await context
                                            .read<ImageCubit>()
                                            .uploadImageType(pickedImage);

                                        urlLinks.forEach((element) {
                                          setState(() {
                                            imageListType.add(element);
                                          });
                                        });
                                      },
                                      child: const Text("Add Image"),
                                    ),
                                  ),
                                  CustomtextFieldEdit(
                                    controller: nameType,
                                    label: "Name Type",
                                  ),
                                  CustomtextFieldEdit(
                                    controller: capacity,
                                    label: "Capacity",
                                  ),
                                  CustomtextFieldEdit(
                                    controller: price,
                                    label: "Price",
                                  ),
                                  CustomtextFieldEdit(
                                    controller: descriptionType,
                                    label: "Description",
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await context
                                          .read<TypeCubitData>()
                                          .update(TipeModel(
                                              id: state.tipe[index].id,
                                              name: nameType.text,
                                              price: double.parse(price.text),
                                              facility: [],
                                              images: imageListType,
                                              capacity:
                                                  int.parse(capacity.text),
                                              description: descriptionType.text,
                                              adminId:
                                                  state.tipe[index].adminId));
                                      DialogUtils.alertDialog(
                                          context,
                                          "Success",
                                          "Data Tipe berhasil dirubah");
                                    },
                                    child: const Text("Save"),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return const SizedBox(
                        child: Text("No Data"),
                      );
                    }
                  },
                ),
              )
            ],
          ),
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
