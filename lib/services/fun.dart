import 'package:clipboard/clipboard.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Fun{
  // This a function is open any news in browser
 static void openLink(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

 static void shareLink(String url) async {
   Share.share('$url', subject: 'Look what I made!');

 }
 static Future<void> copyLink(String url) async {
   FlutterClipboard.copy('$url').then(( value ) => print('copied'));
 }
}