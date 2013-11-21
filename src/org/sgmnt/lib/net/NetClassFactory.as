/**
 *
 * Copyright (c) 2010 - 2013, http://sgmnt.org/
 * 
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */
package org.sgmnt.lib.net{
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	
	/**
	 * Loader, URLLoader 等の Loader 関連クラスを生成するための Factory クラス.
	 * initialize で Loader と URLLoader を継承したクラスを渡しておくと,そのクラスを使うようになる.
	 * @author sgmnt.org
	 */
	public class NetClassFactory{
		
		private static var _loaderClass:Class;
		private static var _urlLoaderClass:Class;
		private static var _netStreamClass:Class;
		
		/**
		 * Private Constructor.
		 * @param pvt
		 */
		public function NetClassFactory(pvt:PrivateClass){}
		
		/**
		 * 初期化処理.
		 * @param loaderClass
		 * @param urlLoaderClass
		 * @param netStreamClass
		 */
		public static function initialize( loaderClass:Class = null, urlLoaderClass:Class = null, netStreamClass:Class = null ):void{
			_loaderClass    = loaderClass;
			_urlLoaderClass = urlLoaderClass;
			_netStreamClass = netStreamClass;
		}
		
		/**
		 * Loader インスタンスを生成します.
		 * @param context
		 * @param loadLocalFileFirst
		 * @return 
		 */
		public static function createLoader( context:LoaderInfo = null, loadRemoteFileFirst:Boolean = false ):Loader{
			if( _loaderClass ){
				return new _loaderClass( context, loadRemoteFileFirst ) as Loader;
			}
			return new Loader();
		}
		
		/**
		 * URLLoader インスタンスを生成します.
		 * @param context
		 * @param loadRemoteFileFirst
		 * @return 
		 */
		public static function createURLLoader( context:LoaderInfo = null, loadRemoteFileFirst:Boolean = false ):URLLoader{
			if( _urlLoaderClass ){
				return new _urlLoaderClass( context, loadRemoteFileFirst ) as URLLoader;
			}
			return new URLLoader();
		}
		
		/**
		 * NetStream インスタンスを生成します.
		 * @param connection
		 * @param context
		 * @param loadLocalFileFirst
		 * @param peerID
		 * @return 
		 */
		public static function createNetStream( connection:NetConnection, context:LoaderInfo = null, loadRemoteFileFirst:Boolean = false, peerID:String = "connectToFMS" ):NetStream{
			if( _netStreamClass ){
				return new _netStreamClass( connection, context, loadRemoteFileFirst, peerID ) as NetStream;
			}
			return new NetStream( connection, peerID );
		}
		
	}
	
}

class PrivateClass{}