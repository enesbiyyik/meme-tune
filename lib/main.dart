import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutteray/welcome.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/data.dart' as meme;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize without device test ids.
  Admob.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemeTune',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Welcome(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

BannerAd myBanner = BannerAd(
  adUnitId: "ca-app-pub-2344041854959623/4410889272",
  size: AdSize.smartBanner,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

  @override
  void initState() {
    myBanner
  // typically this happens well before the ad is shown
  ..load()
  ..show(
    // Positions the banner ad 60 pixels from the bottom of the screen
    anchorOffset: 5.0,
    // Positions the banner ad 10 pixels from the center of the screen to the right
    //horizontalCenterOffset: 10.0,
    // Banner Position
    anchorType: AnchorType.bottom,
  );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Meme Project"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          if (index % 2 == 0 && index != 0) {
            return Container(
              child: AdmobBanner(
                      adUnitId: "ca-app-pub-2344041854959623/4410889272",
                      adSize: AdmobBannerSize.BANNER),
            );
          } else {
            return Container();
          }
        },
        itemCount: meme.MemeSongData.name.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(meme.MemeSongData.name[index]),
              subtitle: Text(meme.MemeSongData.category[index]),
              onTap: () => redirect(context, index),
            ),
          );
        },
      ),
    );
  }

  void redirect(BuildContext ctx, int index) {
    showDialog(
        context: ctx,
        barrierDismissible: true,
        builder: (ctx) {
          return AlertDialog(
            content: Container(
              height: 350,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      height: 100,
                      child: RaisedButton(
                        onPressed: (){
                          _launchInWebViewOrVC((meme.MemeSongData.youtube[index])).then((value) => null);
                          debugPrint(meme.MemeSongData.youtube[index]);
                          },
                        color: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        child: Text("Play on YouTube", style: TextStyle(color: Colors.white, fontSize: 24),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      height: 100,
                      child: RaisedButton(
                        onPressed: () => _launchInWebViewOrVC((meme.MemeSongData.spotify[index])),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        child: Text("Play on Spotify", style: TextStyle(color: Colors.white, fontSize: 24),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      height: 100,
                      child: RaisedButton(
                        onPressed: () => _launchInWebViewOrVC((meme.MemeSongData.spotify[index])),
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        child: Text("Play on SoundCloud", style: TextStyle(color: Colors.white, fontSize: 24),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}