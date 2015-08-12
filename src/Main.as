package 
{
	//import flash.display.DisplayObject;
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.filesystem.File;
	
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	import air.update.events.StatusUpdateErrorEvent;
	
	import data.Config;
	import data.DataContainer;
	import starling.utils.Color;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;

	// To show a Preloader while the SWF is being transferred from the server, 
	// set this class as your 'default application' and add the following 
	// compiler argument: '-frame StartupFrame Demo_Web'
	 
	
	[SWF(width="1024", height="768", frameRate="24", backgroundColor="#222222")]
	public class Main extends MovieClip
	{
		private const STARTUP_CLASS:String = "SimgirlsLovemore";
		
		private var progressTxt:TextField;
		private var mProgressIndicator:Shape;
		private var mFrameCount:int = 0;
		public static var verifyKey:String;
		
		private var appUpdater:ApplicationUpdaterUI=new ApplicationUpdaterUI();
		public function Main()
		{
			 
			var parameters:Object=this.loaderInfo.parameters;
			DebugTrace.msg("Preloader.auth\\Key:"+parameters.authkey);
			verifyKey=parameters.authkey;
			Config.verifyKey=verifyKey;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stop();
		}
		
		private function onAddedToStage(event:Event):void 
		{
			//stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			ViewsContainer.GameStage=stage;
			
			var format:TextFormat=new TextFormat();
			format.size=25;
			format.color=0xFFFFFF;
			progressTxt=new TextField();
			progressTxt.selectable=false;
			progressTxt.autoSize=TextFieldAutoSize.CENTER;
			progressTxt.defaultTextFormat=format;
			addChild(progressTxt);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onEnterFrame(event:Event):void 
		{
			var bytesLoaded:int = root.loaderInfo.bytesLoaded;
			var bytesTotal:int  = root.loaderInfo.bytesTotal;
			
			if (bytesLoaded >= bytesTotal)
			{
				dispose();
				checkAppVersion();
				run();
			}
			else
			{
				if (mProgressIndicator == null)
				{
					mProgressIndicator = createProgressIndicator();
					mProgressIndicator.x = stage.stageWidth  / 2;
					mProgressIndicator.y = stage.stageHeight / 2;
					addChild(mProgressIndicator);
					
				}
				else
				{
					if (mFrameCount++ % 5 == 0)
						mProgressIndicator.rotation += 45;
				}
				
			}
			
			var _loaded:Number=Number((bytesLoaded/1024).toFixed(2));
			var _total:Number=Number((bytesTotal/1024).toFixed(2));
			progressTxt.text="Loading...."+_loaded+"KB/ "+_total+"KB";
			progressTxt.x=stage.stageWidth/2-progressTxt.width/2;
			progressTxt.y=stage.stageHeight/2+20;
			
		}
		
		private function createProgressIndicator(radius:Number=12, elements:int=8):Shape
		{
			var shape:Shape = new Shape();
			var angleDelta:Number = Math.PI * 2 / elements;
			var x:Number, y:Number;
			var innerRadius:Number = radius / 4;
			var color:uint;
			
			for (var i:int=0; i<elements; ++i)
			{
				x = Math.cos(angleDelta * i) * radius;
				y = Math.sin(angleDelta * i) * radius;
				color = (i+1) / elements * 255;
				
				shape.graphics.beginFill(Color.rgb(color, color, color));
				shape.graphics.drawCircle(x, y, innerRadius);
				shape.graphics.endFill();
			}
			
			return shape;
		}
		
		private function dispose():void 
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			if (mProgressIndicator)
			{
				removeChild(mProgressIndicator);
				mProgressIndicator = null;
				
			}
			if(progressTxt)
			{
				removeChild(progressTxt);
			}
		}
		private function checkAppVersion():void
		{
			setApplicationVersion();
		 
			appUpdater.configurationFile = File.applicationDirectory.resolvePath("update_config.xml");
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
			appUpdater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, onStatusUpdateError);
			appUpdater.addEventListener(ErrorEvent.ERROR, onError);
			appUpdater.initialize(); 
		}
		private function setApplicationVersion():void
		{
			var appXML:XML=NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace=appXML.namespace();
			trace("checkAppVersion Current version is " +appXML.ns::versionNumber);
			DataContainer.currentVersion=appXML.ns::versionNumber;
		}
		private function onUpdate(e:UpdateEvent):void
		{
			 
			appUpdater.checkNow();
			
		}
		private function onStatusUpdateError(e:StatusUpdateErrorEvent):void
		{
			trace(e.toString());
		}
		private function onError(e:ErrorEvent):void
		{
			trace(e.toString());
			
		}
	
		private function run():void 
		{
			nextFrame();
			
			var startupClass:Class = getDefinitionByName(STARTUP_CLASS) as Class;
			if (startupClass == null)
				throw new Error("Invalid Startup class in Preloader: " + STARTUP_CLASS);
			
			var startupObject:MovieClip = new startupClass() as MovieClip;
			if (startupObject == null)
				throw new Error("Startup class needs to inherit from Sprite or MovieClip.");
			
			addChildAt(startupObject, 0);
		}
	}
}