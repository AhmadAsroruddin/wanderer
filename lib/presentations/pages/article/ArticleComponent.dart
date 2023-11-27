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

  const ArticleComponent({
    super.key,
    required this.title,
    required this.articleUrl,
    required this.imgUrl
  });

  void _launchUrl(String url) async {
    final Uri a = Uri.parse(url);
    if (!await launchUrl(a)) {
      throw Exception('Could not access URL');
    }
  }

  void _shareToWhatsApp() {
    String whatsappUrl = "whatsapp://send?text=$title\n$articleUrl";
    _launchUrl(whatsappUrl);
  }

  void _shareToLine() {
    String lineUrl = "https://social-plugins.line.me/lineit/share?url=$articleUrl&text=$title";
    _launchUrl(lineUrl);
  }

  void _shareToFB() {
    String url = "https://www.facebook.com/sharer/sharer.php?u=$articleUrl";
    _launchUrl(url);
  }

  void _shareToX() {
    String url = "https://twitter.com/intent/tweet?url=$articleUrl&text=%20$title%0A";
    _launchUrl(url);
  }

  void _shareToIG() {
    String url = "instagram://send?text=$title&url=$imgUrl";
    _launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchUrl(articleUrl);
      },
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
              child: Container(
                width: 1000,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 10, color: Colors.white),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      'https://cdn.detik.net.id/detik2/images/logo-detik-d.png',
                      height: 32,
                      width: 32,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'detik.com',
                      style: GoogleFonts.roboto(fontSize: 12),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ModalShare(
                              title: title,
                              share_WA: _shareToWhatsApp,
                              share_FB: _shareToFB,
                              share_Line: _shareToLine,
                              share_IG: _shareToIG,
                              share_X: _shareToX
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.share,
                        size: 24,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5, right: 5)),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ModalTitikTiga();
                          },
                        );
                      },
                      child: const Icon(
                        Icons.more_vert,
                        size: 24,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
