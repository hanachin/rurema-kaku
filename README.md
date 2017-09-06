るりま書く
==========

つかいかた
----------

```
$ rake setup
$ bundle exec guard
```

るりまのドキュメントは`doctree/refm/api/src`ディレクトリの下にあります。

guardを実行したあと http://localhost:9292/ を開きます。
メソッドの説明を変更したりコード例を追記するなどファイルを編集すると、
ブラウザが自動でリロードされ編集中のるりまのプレビューが表示されます。

いい感じにかけたら`doctree`ディレクトリの下に移動して変更をコミットしPull Requestを送りましょう。


1. https://github.com/rurema/doctree をfork
2. `doctree` ディレクトリ以下に移動、変更をコミット
   ```
   $ cd doctree
   $ git checkout -b your_change
   $ git add .
   $ git commit
   ```
3. 1でforkしたリポジトリをremoteに追加
   ```
   $ git remote add yourname https://github.com/yourname/doctree
   ```
4. リポジトリに変更をpush
   ```
   $ git push yourname HEAD
   ```
5. https://github.com/rurema/doctree でPull Requestを作成

ほしいきのう
----

特にローカルマシンでセットアップせずにブラウザからコントリビュートできる機能

ドキュメントがまだ書かれていないエントリなど、どれを書けばいいかわかる機能

参考: https://github.com/hanachin/rurema-scripts
