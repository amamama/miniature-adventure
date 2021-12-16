# miniature-adventure
tdmelodicをopenjtalkの辞書にするやつ

FAQ
- リポジトリの名前はgithubのおすすめをそのまま使った．特に意味はない．
- このリポジトリはメンテナンスされない
- 文字コードはUTF-8を前提にしている
- 私はNLPド素人
- なんか間違ってたらそっちが気合で直してくれ
- tdmelodicをforkするのが面倒だったしforkするほどの変更ではない

## 動機
[voicevox engine](https://github.com/VOICEVOX/voicevox_engine)のpyopenjtalk（mecab）に使用されている辞書を改善してより良いアクセントを得たい．
手始めに[tdmelodic](https://github.com/PKSHATechnology-Research/tdmelodic)を使うことを検討したが， https://github.com/sarulab-speech/tdmelodic_openjtalk の辞書のsurfaceが気に入らなかった，そしてその辞書の生成スクリプトが存在しなくて再現できなかったので自分でtdmelodicからopenjtalk用の辞書を生成することにした．

## 方法

https://github.com/PKSHATechnology-Research/tdmelodic をcloneし[パッチ](./tdmelodic_modify_accent.patch)を当てる．
パッチの内容は見てわかると思うので不満なら適当に書き換える．
[tdmelodicのマニュアル](https://tdmelodic.readthedocs.io/ja/latest/index.html)に従って辞書を生成する．

生成された辞書を`tdmelodic.csv`とし，以下のコマンドを実行する．（ここでは生成する辞書の名前を`tdmelodic_openjtalk.csv`）とする．
grepコマンドで2回以上`[`が出てくるor`]`行を削除する．これをしないと間違ったアクセント核の単語も追加されてしまう．

```sh
grep -v '[^,]*\][^,]*\]\|[^,]*\[[^,]*\[' tdmelodic.csv | awk -f tdmelodic_to_openjtalk.awk > tdmelodic_openjtalk.csv
```

生成された`tdmelodic_openjtalk.csv`がコンパイル前の辞書ファイルとなる．これはアクセント核の情報が付加されているので，openjtalkがmecabでパースするときにこの辞書を用いることでより良いアクセント推定が行われることが期待できる．また，neologd．tdmelodicの使用によりアクセント結合型の情報が失われているが https://github.com/sarulab-speech/tdmelodic_openjtalk の辞書ファイルにも付加されていなかったのでこれで良いものとする．
~~まあこれに入っているのは日常会話では出てこない固有名詞が多めなうえopenjtalkのndjのアクセント結合アルゴリズムが優秀なのであまり効果は感じられないが~~

最近（2021/12/17）pyopenjtalkがユーザ辞書を扱えるようにする[PR](https://github.com/VOICEVOX/pyopenjtalk/pull/2)が出たのでこれが承認されれば多分この辞書ファイルを追加するだけで良いはずである．
openjtalkの辞書と一緒にしたい場合，辞書ディレクトリにコピーし，`make` もしくは手動で `mecab-dict-index -d . -o . -f UTF-8 -t UTF-8`を行えば良いはず．

pyopenjtalkは環境変数`OPEN_JTALK_DICT_DIR`で辞書の場所を指定できるので，適切にこの環境変数を設定することでこれを追加した辞書としていない辞書を切り替えることが可能である．

## したいこと
tdmelodicには[一件ずつ推論するモード](https://tdmelodic.readthedocs.io/ja/latest/pages/onebyone.html)というのがあるのでvoicevoxとうまく組み合わせられないだろうか（良いアクセントが得られるのかは疑問が残るが）

## 愚痴
tdmelodic_openjtalkの生成スクリプトをよこせ．neologd更新止まるならそう書いとけ．openjtalkはv1.11で辞書にunidic-csj-2.2.0が追加されたが現在は3.1.0があるんだからアプデしろや．neologdはunidicの2.1.2を前提にしているのがなお悪い．しかもopenjtalkは多分文脈IDが昔から変わってないからIDがmatrixがたかだか1400程度なの良くないしそれぞれで生成された辞書のIDを変換しないといけないの将来エンバグしそう．tdmelodicは全体的に良かったんだけど学習するためのデータが上がってるともっと良かった．論文では4日かけて学習したっぽいから自分では学習を回さないと思うけど．
