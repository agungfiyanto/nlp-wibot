import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stages {
  List kalimat = [];

  dynamic stemming(String message) async {
    // Dilakukan Case Folding, Tokenizing, Stemming
    try {
      var dataStemming = await http
          .get(Uri.parse(
              "https://lagawayu.com/dataset-wibot/stemming/?pesan=$message"))
          .timeout(Duration(seconds: 3));
      List resultStemming = jsonDecode(dataStemming.body);
      return resultStemming;
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  void setAndNormalization(List words, SplayTreeMap<String, String> dataset) {
    for (int index = 0; index < words.length; index++) {
      if (dataset.containsKey(words[index])) {
        var kataGanti = words[index];
        words[index] = dataset[kataGanti];
      }
    }
    kalimat = words;
  }

  void slangWord(SplayTreeMap<String, String> dataset, [List? words]) {
    if (words != null) {
      kalimat = words;
    }

    for (int index = 0; index < kalimat.length; index++) {
      if (dataset.containsKey(kalimat[index])) {
        var kataGanti = kalimat[index];
        kalimat[index] = dataset[kataGanti];
      }
    }
  }

  void filtering(SplayTreeSet<String> dataset, [List? words]) {
    if (words != null) {
      kalimat = words;
    }

    for (int index = kalimat.length - 1; index >= 0; index--) {
      if (dataset.contains(kalimat[index])) {
        kalimat.remove(kalimat[index]);
      }
    }
  }
}
