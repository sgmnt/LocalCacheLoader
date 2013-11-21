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
package org.sgmnt.lib.net
{
	
	import flash.display.LoaderInfo;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.escapeMultiByte;
	
	/**
	 * LocalCache 系のプログラムの設定を保持します.
	 * @author kawakita
	 */	
	public class LocalCacheSettings
	{
		
		// ------- MEMBER -----------------------------------------------------------------
		
		private static var _WORKING_DIRECTORY:File;
		private static var _DEFAULT_CONTEXT:LoaderInfo;
		private static var _FIRST_TIME_DICTIONRY:Dictionary = new Dictionary();
		
		// ------- PUBLIC STATIC ----------------------------------------------------------
		
		/**
		 * 保存されるローカルパスを取得します.
		 * @param urlRequest
		 * @return 
		 */		
		public static function getCacheURL( request:URLRequest ):String{
			var f:File;
			var url:String = request.url;
			if( url.indexOf("http") == 0 ){
				// http リクエストの場合キャッシュディレクトリを調べる.
				url = LocalCacheSettings.encode(url);
				f   = new File( _WORKING_DIRECTORY.resolvePath( url.substring( url.indexOf("://") + 3, url.length ) ).nativePath );
			}else{
				f = new File( request.url );
			}
			return f.nativePath;
		}
		
		public static function encode(url:String):String{
			return url.replace(/\?/gi,"__hatena__").replace(/:(\d+)/gi,"__colon__$1");
		}
		
		public static function decode(url:String):String{
			return url.replace(/__hatena__/gi,"?").replace(/__colon__/gi,":");
		}
		
		/**
		 * キャッシュを保存するディレクトリ.
		 * @return 
		 */		
		public static function get WORKING_DIRECTORY():File
		{
			return _WORKING_DIRECTORY;
		}
		public static function set WORKING_DIRECTORY(value:File):void
		{
			var file:File = new File( value.nativePath );
			if( !file.exists ){
				file.createDirectory();
			}else if( !file.isDirectory ){
				throw new Error( "Cannot create directory." + file.nativePath + " is already exists.");
			}
			_WORKING_DIRECTORY = file;
		}
		
		/**
		 * 読み込みを行う DefaultContext.
		 * @return 
		 */		
		public static function get DEFAULT_CONTEXT():LoaderInfo
		{
			return _DEFAULT_CONTEXT;
		}
		public static function set DEFAULT_CONTEXT( context:LoaderInfo ):void
		{
			_DEFAULT_CONTEXT = context;
		}
		
		/**
		 * 初回の読み込みであるかを調べるための辞書.
		 * @return 
		 */
		internal static function get FIRST_TIME_DICTIONRY():Dictionary
		{
			return _FIRST_TIME_DICTIONRY;
		}
		
		public function LocalCacheSettings(){}
		
	}
	
}