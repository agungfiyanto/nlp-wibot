import 'dart:convert';
import 'package:nlp/nlp.dart';
import 'package:http/http.dart' as http;
import 'package:nlp/src/tree.dart';

dynamic konversiData(var url) async {
  try {
    var dataset = await http.get(url).timeout(Duration(seconds: 3));
    return jsonDecode(dataset.body);
  } catch (e) {
    return {"error": e.toString()};
  }
}

void main() async {
  String pesan = "Saya mau membeli trk";

  var url = Uri.parse("https://lagawayu.com/dataset-wibot");
  var dataset = await konversiData(url);
  List<dynamic> dataNormalization = dataset["normalization"];
  List<dynamic> dataSlangWord = dataset["slangword"];
  List<dynamic> dataStopWord = dataset["stopword"];

  Stages stages = Stages();
  Tree dataTree = Tree(dataNormalization, dataSlangWord, dataStopWord);
  stages.setAndNormalization(
      await stages.stemming(pesan), dataTree.normalization);
  stages.slangWord(dataTree.slangWord);
  stages.filtering(dataTree.stopWord);
  print(stages.kalimat);
}
