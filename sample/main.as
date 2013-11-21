package{
	
	import flash.display.MovieClip;
	
	import org.sgmnt.lib.net.*;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.filesystem.File;
	
	public class main extends MovieClip {
		
		private var _loader:Loader;
		
		public function main() {
			
			// Setup cache Directory.
			LocalCacheSettings.WORKING_DIRECTORY = File.applicationDirectory;
			//LocalCacheSettings.WORKING_DIRECTORY = File.applicationStorageDirectory;
			
			// init Factory Class.
			NetClassFactory.initialize( LocalCacheLoader, LocalCacheURLLoader, LocalCacheNetStream );
			
			// Load Google Logo.
			_loader = NetClassFactory.createLoader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _onComplete );
			_loader.load( new URLRequest("https://www.google.co.jp/images/srpr/logo11w.png") );
			
		}
		
		private function _onComplete(e:Event):void{
			addChild( _loader );
		}
		
	}
	
}
