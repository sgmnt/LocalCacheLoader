LocalCacheLoader
================

LocalCacheLoader は Loader/URLLoaderと完全互換の
読み込み用クラスです。

このクラスを利用すると、読み込んだ画像やテキストのデータを
ローカルに一度保存し、同様のファイルが既に存在する場合には
そのファイルを使うようになります。

これにより、同一ファイルの無駄な通信をなくす事が出来ます。
使い方は通常の Loader/URLLoader と全く同じです。

違う点は、使用前にいくつか初期化プロセスが必要な事。
クラスの生成に専用のFactory クラスを用いる必要がある事です。

AIR for Android / AIR for iOS でも利用可能です。

## 使い方

sample/main.as を見てもらうのがわかりやすいですが
以下のような感じで初期化してから使います。
後は勝手にローカルに保存してくれます。

URL を元にファイルを一意に保つので、完全に同一のURLでない限り
ファイルが上書きされる事もありません。

    // Setup cache Directory.
    // ここで指定したディレクトリにキャッシュされます.
    LocalCacheSettings.WORKING_DIRECTORY = File.applicationDirectory;
    
    // AIR for Android, AIR for iOS の場合は以下を設定してください.
    //LocalCacheSettings.WORKING_DIRECTORY = File.applicationStorageDirectory;
	  
  	// init Factory Class.
  	// ファクトリクラスを初期化しなかった場合は 通常の Loader 等が使われます。
  	NetClassFactory.initialize( LocalCacheLoader, LocalCacheURLLoader, LocalCacheNetStream );
	  
  	// Create Class.
	  // ここの第二引数を true にすると、ローカルに保存されたキャッシュの有る無しを問わず
	  // 必ずWeb上からファイルをとるようになります。
	  _loader = NetClassFactory.createLoader( null, false );
	  // 後は普通に使います。
    _loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _onComplete );
	  _loader.load( new URLRequest("https://www.google.co.jp/images/srpr/logo11w.png") );
    
    

