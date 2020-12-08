import 'package:cloud_firestore/cloud_firestore.dart';

class MemeSongData {
  static List<String> name = [];
  static List<String> id = [];
  static List<String> category = [];
  static List<String> spotify = [];
  static List<String> youtube = [];
  static List<List> keyword = [];

  static void getMemeData() async {
    QuerySnapshot doc = await Firestore.instance.collection("meme-song-data").getDocuments();
    List<DocumentSnapshot> dok = doc.documents;
    for(int i = 0; i < dok.length; i++){
      name.add(dok[i]["name"]);
      id.add(dok[i]["id"]);
      category.add(dok[i]["category"]);
      keyword.add(dok[i]["keyword"]);
      spotify.add(dok[i]["spotify-url"]);
      youtube.add(dok[i]["youtube-url"]);
    }
  }
}
