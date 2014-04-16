package utils
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import controller.Assets;
	import controller.DrawerInterface;
	import controller.FilterInterface;
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import data.DataContainer;
	
	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.animation.WorldClock;
	import dragonBones.factorys.StarlingFactory;
	
	import model.SaveGame;
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	import starling.utils.Color;
	import starling.utils.VertexData;
	
	import utils.DebugTrace;
	
	//import starling.utils.getNextPowerOfTwo;
	
	public class DrawManager implements DrawerInterface
	{
		
		private var target:*;
		private var bmpData:BitmapData;
		private var porperties:Object;
		private var gender:String;
		private var basemodel:Sprite;
		private var body:MovieClip;
		private var hair:Image;
		private var eyes:Image;
		private var pants:Image;
		private var clothes:Image;
		private var hairAtlas:TextureAtlas ;
		private var hairIndex:Number;
		private var pantsAtlas:TextureAtlas;
		private var clothesAtlas:TextureAtlas;
		private var featureAtlas:TextureAtlas;
		private var pantsIndex:Number;
		private var clothesIndex:Number;
		private var features:Image;
		private var featuresIndex:Number;
		private var onReadyComplete:Function;
		private var factory:StarlingFactory;
		private var armature:Armature;
		private var bonmodel:Object;
		private var bonbody:Bone;
		private var piechart:MovieClip;
		private var fIndex:Number=0;
		private var picchartImg:Image;
		private var result:Number=0;
		private var filter:FilterInterface=new FilterManager();
		public function setSource(src:*):void
		{
			target=src
			
		}
		
		public function drawCircle(attr:Object):void
		{
			
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(attr.color);
			shape.graphics.drawCircle(attr.radius,attr.radius,attr.radius);
			shape.graphics.endFill();
			bmpData= new BitmapData(shape.width,shape.height, true, attr.color);
			bmpData.draw(shape);
			
		}
		public function getBitmapdata():BitmapData
		{
			return bmpData;
			
		}
		public function setBitmapPorperties(obj:Object):void
		{
			porperties=obj
			
		}
		
		public function copyAsBitmapData(sprite:DisplayObject,rec:Rectangle=null,point:Point=null):BitmapData
		{
			/*var nativeWidth:Number = Starling.current.stage.stageWidth;
			var nativeHeight:Number = Starling.current.stage.stageHeight;
			
			if (sprite == null) 
			return null;
			
			//var resultRect:Rectangle=rec;
			var resultRect:Rectangle = new Rectangle();
			sprite.getBounds(sprite, resultRect);
			
			var result:BitmapData = new BitmapData(rec.width, rec.height, porperties.transparent,porperties.bgcolor);
			var context:Context3D = Starling.context;
			var scale:Number = Starling.contentScaleFactor;
			
			var support:RenderSupport = new RenderSupport();
			RenderSupport.clear();
			
			support.setOrthographicProjection(rec.x,rec.y, nativeWidth, nativeWidth);
			support.applyBlendMode(true);
			
			
			support.translateMatrix( -point.x, -point.y);
			support.pushMatrix(); 
			support.blendMode = sprite.blendMode;
			sprite.render(support, 1.0);
			support.popMatrix();
			support.finishQuadBatch();
			
			context.drawToBitmapData(result);	
			
			
			return result;*/
			
	 
			if ( sprite == null) {
				return null;
			}
			 
			
			var resultRect:Rectangle = new Rectangle();
			sprite.getBounds(sprite, resultRect);
			
			var context:Context3D = Starling.context;
			var scale:Number = Starling.contentScaleFactor;
			
			var nativeWidth:Number = Starling.current.stage.stageWidth;
			var nativeHeight:Number = Starling.current.stage.stageHeight;
			
			var support:RenderSupport = new RenderSupport();
			RenderSupport.clear();
			support.setOrthographicProjection(0,0,nativeWidth, nativeHeight);
			support.applyBlendMode(true);
			
			if (sprite.parent){
				support.transformMatrix(sprite.parent);
			}
			
			support.translateMatrix(-point.x, -point.y);
			
			var result:BitmapData = new BitmapData(nativeWidth, nativeHeight, true, 0x00000000);
			
			support.pushMatrix();
			
			support.blendMode = sprite.blendMode;
			support.transformMatrix(sprite);
			sprite.render(support, 1.0);
			support.popMatrix();
			
			support.finishQuadBatch();
			
			context.drawToBitmapData(result);   
			
			var w:Number = sprite.width;
			var h:Number = sprite.height;
			
			if (w == 0 || h == 0) {
				return null;
			}
			
			var returnBMPD:BitmapData = new BitmapData(w, h, true, 0);
			//var cropArea:Rectangle = new Rectangle(0, 0, sprite.width, sprite.height);
			
			returnBMPD.draw( result, null, null, null, rec, true );
			return returnBMPD;
			
			
			
		}
		 
		public function drawCharacter(model:Sprite,attr:Object):void
		{
			basemodel=model;
			 
			var savedata:SaveGame=FloxCommand.savegame;
			gender=attr.gender
			DebugTrace.msg("DrawManager.drawCharacter gender:"+gender);
			
			body=Assets.getDynamicAtlas(gender+"Body");
			body.smoothing=TextureSmoothing.TRILINEAR;
			
			var _color:Number=savedata.avatar.skincolor;
			body.color=Color.rgb(Color.getRed(_color),Color.getGreen(_color),Color.getBlue(_color));
			basemodel.addChild(body);
			
			DebugTrace.msg("DrawManager.drawCharacter attr:"+JSON.stringify(attr));
			if(attr.width && attr.height)
			{
				basemodel.width=attr.width;
				basemodel.height=attr.height;
			}
			else
			{
				basemodel.scaleX=attr.scaleX
				basemodel.scaleY=attr.scaleY;
			}
		
		}
		public function updateBaseModel(target:String):void
		{
			
			//var part:DisplayObject=basemodel.getChildByName(target);
			//DebugTrace.msg("DrawManager.updateBaseModel target:"+ target)
			var savedata:SaveGame=FloxCommand.savegame;
			hairIndex=savedata.avatar.hairstyle;
			pantsIndex=savedata.avatar.pants;
			clothesIndex=savedata.avatar.clothes;
			featuresIndex=savedata.avatar.features;
			//DebugTrace.msg("DrawManager.updateBaseModel gender:"+ gender)
			//DebugTrace.msg("DrawManager.updateBaseModel featuresIndex:"+ featuresIndex)
			var pos:Point=switchPosition(target);
			var _color:Number;
			switch(target)
			{
				case "Hair":
					
					var texture:Texture=Assets.getTexture(gender+"HairStyle");
					var xml:XML=Assets.getAtalsXML(gender+"HairStyleXML");
					hairAtlas = new TextureAtlas(texture, xml);
					var atlas_texture:Texture=hairAtlas.getTexture("hair"+hairIndex);
					hair=new Image(atlas_texture);
					hair.smoothing=TextureSmoothing.TRILINEAR;
					hair.name=target;
					hair.x=pos.x
					hair.y=pos.y;
					_color=savedata.avatar.haircolor;
					hair.color=Color.rgb(Color.getRed(_color),Color.getGreen(_color),Color.getBlue(_color));
					basemodel.addChild(hair);
					break
				case "HairStyle":
					var hairTexture:Texture=hairAtlas.getTexture("hair"+hairIndex);
					hair.smoothing=TextureSmoothing.TRILINEAR;
					hair.texture=hairTexture;
					break
				case "Eyes":
					var eyes_texture:Texture=Assets.getTexture(gender+"Eyes");
					eyes=new Image(eyes_texture);
					eyes.smoothing=TextureSmoothing.TRILINEAR;
					eyes.name=target;
					eyes.x=pos.x;
					eyes.y=pos.y;
					_color=savedata.avatar.eyescolor;
					eyes.color=Color.rgb(Color.getRed(_color),Color.getGreen(_color),Color.getBlue(_color));
					basemodel.addChild(eyes);
					break
				case "Pants":
					var pants_texture:Texture=Assets.getTexture(gender+"PantsStyle");
					xml=Assets.getAtalsXML(gender+"PantsStyleXML");
					pantsAtlas=new TextureAtlas(pants_texture, xml);
					atlas_texture=pantsAtlas.getTexture("pant"+pantsIndex);
					pants=new Image(atlas_texture);
					pants.smoothing=TextureSmoothing.TRILINEAR;
					pants.name=target;
					pants.x=pos.x;
					pants.y=pos.y;
					basemodel.addChild(pants);
					break
				case "Clothes":
					var clothes_texture:Texture=Assets.getTexture(gender+"Clothes");
					xml=Assets.getAtalsXML(gender+"ClothesXML");
					clothesAtlas=new TextureAtlas(clothes_texture, xml);
					atlas_texture=clothesAtlas.getTexture("clothes"+clothesIndex);
					clothes=new Image(atlas_texture);
					clothes.smoothing=TextureSmoothing.TRILINEAR;
					clothes.name=target;
					clothes.x=pos.x;
					clothes.y=pos.y;
					basemodel.addChild(clothes);
					break
				case "Features":
					var features_texture:Texture=Assets.getTexture(gender+"Features");
					xml=Assets.getAtalsXML(gender+"FeaturesXML");
					featureAtlas = new TextureAtlas(features_texture, xml);
					var featureTexture:Texture=featureAtlas.getTexture("features"+featuresIndex);
					features=new Image(featureTexture);
					features.smoothing=TextureSmoothing.TRILINEAR;
					features.name=target
					features.x=pos.x
					features.y=pos.y;
					basemodel.addChild(features);
					break
				case "FeaturesStyle":
					var featureStyleTexture:Texture=featureAtlas.getTexture("features"+featuresIndex);
					features.texture=featureStyleTexture;
					break
			}
			
			//switch
			
			
			
			
		}
		public function updateModelColor(type:String,rgb:Object):void
		{
			var savedata:SaveGame=FloxCommand.savegame;
			var rgbObj:Object=rgb;
			switch(type)
			{
				case "Hair":
					hair.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
					savedata.avatar.haircolor=hair.color;
					break
				case "Skin":
					body.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
					savedata.avatar.skincolor=body.color;
					break
				case "Eyes":
					eyes.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
					savedata.avatar.eyescolor=eyes.color;
					break
				
				
			}
			//switch
			FloxCommand.savegame=savedata;
			
			
		}
		public function playerModelCopy(target:Sprite,pos:Point):void
		{
			 
			
		
				
				var bitmapdata:BitmapData=copyAsBitmapData(basemodel,new Rectangle(0,0,basemodel.width,basemodel.height),new Point(0,-50)); 
				var bmp:BitmapData=new BitmapData(basemodel.width,550);
				bmp.copyPixels(bitmapdata,new Rectangle(0,0,basemodel.width,550),new Point(0,0));
				
				var profileTexture:Texture = Texture.fromBitmapData(bmp);
				var _player_icon:Sprite=new Sprite();
				_player_icon.useHandCursor=true;
				_player_icon.name="Player";
				var img:Image=new Image(profileTexture);
				img.smoothing=TextureSmoothing.TRILINEAR;
				img.x=pos.x;
				img.y=pos.y;
			  
				target.addChild(img);
				
			 
			
		}
		public function drawPlayerProfileIcon(target:Sprite,scale:Number,point:Point):void
		{
			
			var player_icon:Sprite=target;
			player_icon.useHandCursor=true;
			var shapObj:Object=new Object()
			 
			var rec:Rectangle=new Rectangle(-85,-5,100,100);
			var copyPixelRec:Rectangle=new Rectangle(0,0,100,100);
			if(gender=="Female")
			{
				rec=new Rectangle(-58,10,100,100);
				copyPixelRec=new Rectangle(0,0,100,100);
			}	
				
			var texture:Texture=Assets.getTexture("ProEmpty");
			var bgImg:Image=new Image(texture);
			bgImg.pivotX=bgImg.width/2;
			bgImg.pivotY=bgImg.height/2;
			bgImg.width=rec.width;
			bgImg.height=rec.height;
			player_icon.addChild(bgImg);
			
			var maskImg:Image=new Image(texture);
			maskImg.width=rec.width;
			maskImg.height=rec.height;
			 
			var maskDisplayObject:Sprite = new Sprite();
			maskDisplayObject.addChild(basemodel);
			maskDisplayObject.x=rec.x;
			maskDisplayObject.y=rec.y;
			var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject(-1, false);
			maskedDisplayObject.addChild(maskDisplayObject);
			maskedDisplayObject.mask=maskImg;
			player_icon.addChild(maskedDisplayObject);
			
			var bitmapdata:BitmapData=copyAsBitmapData(maskedDisplayObject,new Rectangle(0,0,maskedDisplayObject.width,maskedDisplayObject.height),new Point(0,0)); 
			var bmp:BitmapData=new BitmapData(rec.width,rec.height);
			bmp.copyPixels(bitmapdata,copyPixelRec,new Point(0,0));
			var profileTexture:Texture = Texture.fromBitmapData(bmp);
			
			var _player_icon:Sprite=new Sprite();
			_player_icon.useHandCursor=true;
			_player_icon.name="Player";
			var img:Image=new Image(profileTexture);
			img.smoothing=TextureSmoothing.TRILINEAR;
			//trace("DrawManager img width:",img.width," ;img height:",img.height);
			img.pivotX=img.width/2;
			img.pivotY=img.height/2;	 
		    _player_icon.addChild(img);
		 
		    player_icon.addChild(_player_icon);
			maskedDisplayObject.removeFromParent(true);
		 
			//trace("DrawManager player_icon width:",player_icon.width," ;player_icon height:",player_icon.height);
			player_icon.scaleX=0.89;
			player_icon.scaleY=0.89;
			player_icon.x=point.x;
			player_icon.y=point.y;
			
		}
		public function drawCharacterProfileIcon(target:Sprite,ch:String,scale:Number):void
		{
			//var fisrtword:String=ch.charAt(0).toUpperCase();
			//var _ch:String=ch.slice(1,ch.length);
			//ch=fisrtword+_ch;
			DebugTrace.msg("DrawManager.drwaCharacterProfileIcon ch:"+ch);
			var texture:Texture=Assets.getTexture("Pro"+ch);
			var xml:XML=Assets.getAtalsXML("Pro"+ch+"XML");
			var atlas:TextureAtlas=new TextureAtlas(texture,xml);
		    var mood:String=DataContainer.getFacialMood(ch);
			DebugTrace.msg("DrawManager.drwaCharacterProfileIcon mood:"+mood);
			var facail_texture:Texture=atlas.getTexture(mood);
			//var texture:Texture=Assets.getTexture("Pro"+ch);
			var img:Image=new Image(facail_texture);
			img.useHandCursor=true;
			img.name=ch.toLowerCase();
			img.smoothing=TextureSmoothing.TRILINEAR;
			img.pivotX=img.width/2;
			img.pivotY=img.height/2;
			img.scaleX=scale;
			img.scaleY=scale;
			target.addChild(img);

			
		}
		public function drawCircyleImage(target:Sprite):void
		{
			var bmpData:BitmapData = getBitmapdata();
			var circle_texture:Texture = Texture.fromBitmapData(bmpData);
			var circle:Image = new Image(circle_texture);
			circle.pivotX=circle.width/2;
			circle.pivotY=circle.height/2;
			target.addChild(circle)
			
			
		}
		public function drawDragonBon(info:Object,callback:Function=null):void
		{
			bonmodel=info; 
			onReadyComplete=callback;
			var textTure:ByteArray=Assets.create(bonmodel.name) as ByteArray;
			factory = new StarlingFactory();
			factory.parseData(textTure);
			factory.addEventListener(flash.events.Event.COMPLETE,textureCompleteHandler)
			
		}
		private function textureCompleteHandler(e:flash.events.Event):void
		{
			
			
			armature = factory.buildArmature(bonmodel.name);
			var dispay_armature:Sprite = armature.display as Sprite;
			dispay_armature.x=bonmodel.pos.x;
			dispay_armature.y=bonmodel.pos.y;
			
			
			var ship:Sprite=bonmodel.container;
			ship.addChild(dispay_armature);
			armature.animation.gotoAndPlay(bonmodel.cate,-1,-1,null)
			
			
			//bonbody = armature.getBone("body");
			//bonbody.childArmature.animation.gotoAndPlay("ready")
			//arm = armature.getBone("armOutside");
			//arm.childArmature.addEventListener(FrameEvent.MOVEMENT_FRAME_EVENT, armFrameEventHandler);
			
			WorldClock.clock.add(armature);
			
			//ship.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
			onReadyComplete();
		}
		private function onEnterFrameHandler(e:EnterFrameEvent):void
		{
			
			
			WorldClock.clock.advanceTime(-1);
			
		}
		public function getBodyBon(target:String):Bone
		{
			
			bonbody = armature.getBone(target);
			return bonbody
		}
		private function switchPosition(part:String):Point
		{
		//	
			var p:Point=new Point();
			var attr:String=gender+"_"+part;
			var pos:Object={
				"Male_Hair":new Point(223,-33),
				"Female_Hair":new Point(54,-45),
				"Male_HairStyle":new Point(223,-33),
				"Female_HairStyle":new Point(54,-39),
				"Male_Eyes":new Point(284,135),
				"Female_Eyes":new Point(199,106),
				"Male_Pants":new Point(164,837),
				"Female_Pants":new Point(99,766),
				"Male_Clothes":new Point(125,264),
				"Female_Clothes":new Point(119,259),
				"Male_Features":new Point(223,0),
				"Female_Features":new Point(152,-4)
			}
			p=pos[attr];
			return p;
		}
		public function drawPieChart(target:Sprite,texture:String):void
		{
			
			var xml_pie:XML=Assets.getAtalsXML(texture+"XML");
			var texture_pie:Texture=Assets.getTexture(texture);
			var atlas:TextureAtlas=new TextureAtlas(texture_pie,xml_pie);
			piechart=new MovieClip(atlas.getTextures("piechart"),60);
			piechart.pivotX=piechart.width/2;
			piechart.pivotY=piechart.height/2;
			piechart.stop();
			
			Starling.juggler.add(piechart);
			target.addChild(piechart);
			
			picchartImg=new Image(piechart.getFrameTexture(fIndex));
			picchartImg.pivotX=picchartImg.width/2;
			picchartImg.pivotY=picchartImg.height/2;
			
			
			target.addChild(picchartImg);
			
			DebugTrace.msg("DrawManager.drawPieChart  picchartImg");
			DebugTrace.obj(picchartImg);
		}
		public function updatePieChart(value:Number):void
		{
			//value -1000~1000
			result=value;
			if(result>1000)
			{
				result=1000
			}else if(result<-1000)
			{
				result=-1000
			}
			//var dating:String=DataContainer.currentDating;
			//var savegame:SaveGame=FloxCommand.savegame;
			//fIndex=0;
			DebugTrace.msg("DrawManager.updatePieChart  result:"+result);
			var color:uint=0xFF66FF;
			picchartImg.scaleX=1;
			if(result<0)
			{
				color=0x00FFFF;
				picchartImg.scaleX=-1;
				result*=-1;
			}
			filter.setSource(picchartImg);
			filter.changeColor(color);
			//piechart.addEventListener(Event.ENTER_FRAME,doRenderPieEnterFrame);
			
			
			doRenderPieEnterFrame();
		}
		private function doRenderPieEnterFrame():void
		{
			//var target:MovieClip=e.currentTarget as MovieClip;
			//DebugTrace.msg("DrawManager.doMoodPieEnterFrame fIndex:"+fIndex+" ; result:"+result);
			/*if(result>fIndex)
			{
			fIndex++;
			if(fIndex==1000)
			{
			fIndex-=1;
			}
			}
			else if(result<fIndex)
			{
			fIndex--;
			}*/
			//var index:Number=Math.floor(fIndex/10);
			var index:Number=Math.floor(result/10);
			if(index==100 || index==-100)
			{
				index=99;
			}
			DebugTrace.msg("DrawManager.doRenderPieEnterFrame  index:"+index);
			picchartImg.texture=piechart.getFrameTexture(index);
			if(fIndex==result)
			{
				
				
				//piechart.removeEventListener(Event.ENTER_FRAME,doRenderPieEnterFrame);
				
				
			}
			//if
		}
		public function drawBackground():*
		{
			//backgound image or sprite
			var flox:FloxInterface=new FloxCommand();
			var date:String=flox.getSaveData("date");
			var time:String=date.split("|")[1];
			if(time=="12")
			{
				var currentScene:String=DataContainer.currentScene+"Day";
			}
			else
			{
				currentScene=DataContainer.currentScene+"Night";
			}
			var scene:String=DataContainer.currentScene;
			if(scene=="BeachScene" || scene=="ParkScene" || scene=="PierScene" || scene=="LovemoreMansionScene")
			{
				var bgTexture:Texture=Assets.getTexture(currentScene);
				var bgImg:*=new Image(bgTexture);
				
			}
			else
			{
				DebugTrace.msg("DrawManager.drawBackground  currentScene:"+DataContainer.currentScene);
				bgImg=Assets.getDynamicAtlas(DataContainer.currentScene);
				bgImg.stop();
			}
			
			
			return bgImg
			
		}
		
	}
}