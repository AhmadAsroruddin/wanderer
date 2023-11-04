import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'modal_titik_tiga.dart';
import 'modal_share.dart';
import '../../shared/theme.dart';

class ArticleComponent extends StatelessWidget {

  final String title;
  final String articleUrl;
  final String imgUrl;

  ArticleComponent({required this.title, required this.articleUrl,  required this.imgUrl});

  void _launchUrl(String _url) async {
    final Uri a = Uri.parse(_url);
    if (!await launchUrl(a)) {
      throw Exception('Could not access URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {_launchUrl(this.articleUrl);},
      child: Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: 
              Container(
                width:1000, height:150,
                decoration: BoxDecoration(
                  border:Border.all(width:10, color: Colors.white),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    this.imgUrl,
                    fit:BoxFit.fill,
                  ),
                ),
              ),
          ),
          SizedBox(height:5),
          Padding(
            padding: EdgeInsets.only(left:8),
            child: Text(
              this.title,
              style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height:5),
          Padding(
            padding: EdgeInsets.only(left:8, right:8),
            child: 
				Row (
					children: <Widget>[
                      Image.network(
                        'https://cdn.detik.net.id/detik2/images/logo-detik-d.png',
                        height:32, width:32,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'detik.com',
                        style: GoogleFonts.roboto(fontSize:12),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ModalShare(title: this.title);
                            },
                          );
                        },
                        child: Icon(
                          Icons.share, size:24,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left:5,right:5)),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ModalTitikTiga();
                            },
                          );
                        },
                        child: Icon(
                          Icons.more_vert, size:24,
                        ),
                      ),
                    ],
                )
          ),
        ],
      ),
    ),
    );
  }
}
