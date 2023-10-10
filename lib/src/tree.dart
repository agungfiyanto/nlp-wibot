import 'dart:collection';

class Tree {
  List<dynamic> _dataNormalization;
  List<dynamic> _dataSlangWord;
  List<dynamic> _dataStopWord;
  List<int> _panjangData = [];

  var normalization = SplayTreeMap<String, String>();
  var slangWord = SplayTreeMap<String, String>();
  var stopWord = SplayTreeSet<String>();

  Tree(this._dataNormalization, this._dataSlangWord, this._dataStopWord) {
    _panjangData.add(_dataNormalization.length);
    _panjangData.add(_dataSlangWord.length);
    _panjangData.add(_dataStopWord.length);

    for (var i = 0; i < 3; i++) {
      for (var index = 0; index < _panjangData[i]; index++) {
        if (_panjangData[i] == _dataNormalization.length) {
          if (_dataNormalization[index] == false) continue;
          normalization[_dataNormalization[index][0]] =
              _dataNormalization[index][1];
        } else if (_panjangData[i] == _dataSlangWord.length) {
          slangWord[_dataSlangWord[index][0]] = _dataSlangWord[index][1];
        } else if (_panjangData[i] == _dataStopWord.length) {
          stopWord.add(_dataStopWord[index]);
        }
      }
    }
  }
}
