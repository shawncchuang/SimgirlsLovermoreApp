package views
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import controller.Assets;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	import starling.display.DisplayObject;

	public class ColorSwatches extends Sprite
	{
		
		private var type:String="";
		private var colorEvent:Event;
		private var swatchesbox:Sprite;
		private var hairfilters:Array;
		private var skinfilters:Array;
		private var eyesfilters:Array;
		private var tilefilters:Array;
		private var hairColors:Array=[0xEA212C,0xF9AF48,0xFFFF00,0x2DB475,0x33ACE0,
			0x2F3590,0x5F3817,0x333333,0xCCCCCC,0xFD7DAC];
		private var skinColors:Array=[0xFFFFFF,0xFED0CB,0xFEDBC1,0xC59C70,0x736358];
		private var eyesColors:Array=[0xEA212C,0xF9AF48,0xFFFF00,0x3EB34F,0x0F73B9,0x2F3590,0x5F3817,0x333333];
		private var upperbodyColors:Array=[0xEA212C,0xF9AF48,0xFFFF00,0x2DB475,0x33ACE0,
			0x2F3590,0x5F3817,0x333333,0xCCCCCC,0xFD7DAC];
		private var lowerbodyColors:Array=[0xEA212C,0xF9AF48,0xFFFF00,0x2DB475,0x33ACE0,
			0x2F3590,0x5F3817,0x333333,0xCCCCCC,0xFD7DAC];

		private var upperbodyfilters:Array;
		private var lowerbodyfilters:Array;
		private var cate:String;
		private var index:Number=-1;
		private var rgbObj:Object
		public function ColorSwatches(cate:String)
		{
			type=cate;
			tilefilters=new Array();
			swatchesbox=new Sprite();
			addChild(swatchesbox);
			
			switch(type)
			{
				case "Hair":
					initHair();
					break
				case "Skin":
					initSkin();
					break
				case "Eyes":
					initEyes();
					break
				case "Upperbody":
					initUpperbody();
					break
				case "Lowerbody":
					 initLowerbody();
					break
			}
		}
		private function initHair():void
		{
			//DebugTrace.msg("ColorSwatches.initHair");
			
			hairfilters=new Array();
			for(var i:uint=0;i<2;i++)
			{
				
				for(var j:uint=0;j<5;j++)
				{
					var id:uint=j+5*i;
					
					var p:Point=new Point(j*50,i*50);	 
					createColorGrid("Hair_"+id,hairColors[id],p);
				}
				//for
			}
			//for
			
		}
		private function initSkin():void
		{
			
			skinfilters=new Array();
			for(var i:uint=0;i<skinColors.length;i++)
			{
				var id:uint=i;
				
				var p:Point=new Point(i*50,0);	 
				createColorGrid("Skin_"+id,skinColors[id],p);	
			}
			
		}
		private function initEyes():void
		{
			
			eyesfilters=new Array();
			
			for(var i:uint=0;i<2;i++)
			{
				
				for(var j:uint=0;j<4;j++)
				{
					var id:uint=j+4*i;
					
					var p:Point=new Point(j*65,i*50);	 
					createColorGrid("Eyes_"+id,eyesColors[id],p);
				}
				//for
			}
			//for
			
		}
		private function initUpperbody():void{

			upperbodyfilters=new Array();
			for(var i:uint=0;i<2;i++)
			{

				for(var j:uint=0;j<5;j++)
				{
					var id:uint=j+5*i;

					var p:Point=new Point(j*50,i*50);
					createColorGrid("Upperbody_"+id,upperbodyColors[id],p);
				}
				//for
			}
			//for
		}
		private function initLowerbody():void{
			lowerbodyfilters=new Array();
			for(var i:uint=0;i<2;i++)
			{

				for(var j:uint=0;j<5;j++)
				{
					var id:uint=j+5*i;

					var p:Point=new Point(j*50,i*50);
					createColorGrid("Lowerbody_"+id,lowerbodyColors[id],p);
				}
				//for
			}

		}
	
		private function createColorGrid(name:String,color:uint,p:Point):void
		{
			//DebugTrace.msg("ColorSwatches.createColorGrid name:"+name)
			
			var shape:Shape = new Shape();
			shape.graphics.lineStyle(1,0xFFFFFF);
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(0,0,40,40);
			shape.graphics.endFill();
			var bmpData:BitmapData = new BitmapData(42, 42,false,color);
			bmpData.draw(shape);
			
			var texture:Texture=Texture.fromBitmapData(bmpData);
			var tile:Button=new Button(texture);
			tile.name=name;
			tile.x=p.x;
			tile.y=p.y;
			tile.addEventListener(Event.TRIGGERED,doSelectColor);
			swatchesbox.addChild(tile);
			
			
			var tilefilter:MovieClip=Assets.getDynamicAtlas("ColorTitleFilters");
			tilefilter.fps=30;
			tilefilter.x=tile.x-2.5;
			tilefilter.y=tile.y-2.5;
			
			swatchesbox.addChild(tilefilter);
			//swatchesbox.sortChildren(doSortCompare);
			tilefilter.visible=false;
			switch(type)
			{
				case "Hair":
					hairfilters.push(tilefilter);
					break
				case "Skin":
					skinfilters.push(tilefilter);
					break
				case "Eyes":
					eyesfilters.push(tilefilter);
					break
				case "Upperbody":
					upperbodyfilters.push(tilefilter);
					break
				case "Lowerbody":
					lowerbodyfilters.push(tilefilter);
					break
			}
			//switch
			
		}
		private function doSortCompare(do1:DisplayObject, do2:DisplayObject):int
		{
			if (do1.y > do2.y) return -1;
			if (do1.y < do2.y) return 1;
			
			if (do1.x > do2.x) return 1;
			if (do1.x < do2.x) return -1;
			return 0;
		}
		private function doSelectColor(e:Event):void
		{
			var btn:Button=e.currentTarget as Button;
			var target:String=btn.name;
			
			cate=target.split("_")[0];
			index=uint(target.split("_")[1]);
			rgbObj=new Object();
			var _color:uint;
			switch(cate)
			{
				case "Hair":
					tilefilters=hairfilters;
					_color=hairColors[index];
					break
				case "Skin":
					tilefilters=skinfilters;
					_color=skinColors[index];
					break
				case "Eyes":
					tilefilters=eyesfilters;
					_color=eyesColors[index];
					break
				case "Upperbody":
					tilefilters=upperbodyfilters;
					_color=upperbodyColors[index];
					break
				case "Lowerbody":
					tilefilters=lowerbodyfilters;
					_color=lowerbodyColors[index];
					break
			}
			DebugTrace.msg("ColorSwatches.doSelectColor cate:"+cate+" ; index:"+index+" ;_color:"+_color);
			rgbObj.r=Color.getRed(_color);
			rgbObj.g=Color.getGreen(_color);
			rgbObj.b=Color.getBlue(_color);
			enabledColorFilters();
			
			var secne:Sprite=ViewsContainer.chacaterdesignScene;
			var _data:Object=new Object();
			_data.rgb=rgbObj;
			_data.type=type;
			colorEvent = new Event(CharacterDesignScene.COLOR_UPDATE, true,_data);
			secne.dispatchEvent(colorEvent);
		}
		private function enabledColorFilters():void
		{
			for(var i:uint=0;i<tilefilters.length;i++)
			{
				var tile:MovieClip=tilefilters[i];
				tile.stop();
				tile.visible=false;
			}
			//for
			
			tilefilters[index].visible=true;
			tilefilters[index].play();
			//swatchesbox.sortChildren(doSortCompare);
			Starling.juggler.add(tilefilters[index]);
			
		}
	}
}