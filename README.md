# miniature-adventure
tdmelodicをopenjtalkの辞書にするやつ

FAQ：レポジトリの名前はgithubのおすすめをそのまま使った．特に意味はない．

## 動機
[voicevox engine](https://github.com/VOICEVOX/voicevox_engine)のpyopenjtalk（mecab）に使用されている辞書を改善してより良いアクセントを得たい．
手始めにtdmelodicを使うことを検討したが， https://github.com/sarulab-speech/tdmelodic_openjtalk の辞書のsurfaceが気に入らなかった，その辞書の生成スクリプトが存在しなくて再現できなかったので自分でtdmelodicからopenjtalk用の辞書を生成することにした．

## 方法

https://github.com/PKSHATechnology-Research/tdmelodic をcloneし[パッチ](./tdmelodic_modify_accent.patch)を当てる．
パッチの内容は見てわかると思うので不満なら適当に書き換える．
[tdmelodicのマニュアル](https://tdmelodic.readthedocs.io/ja/latest/index.html)に従って辞書を生成する．

TBU
