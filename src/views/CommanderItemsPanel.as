package views
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import events.BattleEvent;

import utils.DebugTrace;

import views.BattleScene;
	
	public class CommanderItemsPanel extends Sprite
	{
		private var itemspool:Object=new Object();
		private var flox:FloxInterface=new FloxCommand();
		private var panel:MovieClip;
		private var items:Array;
		private var columns:Number=0;
		private var current_icon:MovieClip;
		public function CommanderItemsPanel()
		{
			//com0=Change Formation
			itemspool={"com0":new Itemcom0(),
				"com1":new Itemcom1(),
				"com2":new Itemcom2(),
				"com3":new Itemcom3()
			}
			initItemsPanel();	
			
		}
		private function initItemsPanel():void
		{
			items=flox.getSaveData("skills").captain;

			DebugTrace.msg("CommanderItemsPanel.initItemsPanel items="+JSON.stringify(items));
			panel=new CommanderItems();
			addChild(panel);
			
			var format:TextFormat=new TextFormat();
			format.font="SimImpact";
			format.size=16;
			format.color=0xFFFFFF;

			var row:Number=0;
			var column:Number=-1;
			for(var i:uint=0;i< items.length;i++)
			{
				
				// var name:String="libItem"+i;

				var itemid:String=items[i].id;
				if(itemid!="com0"){
					var item:MovieClip=itemspool[itemid];
					column++;
					//column=i;
//					if(i>2){
//						row=1;
//						column=i-3;
//					}

					item.name=itemid;
					item.mouseChildren=false;
					item.buttonMode=true;

					item.qty.embedFonts=true;
					item.qty.defaultTextFormat=format;
					item.qty.text="x"+items[i].qty;
					item.x=column*(item.width+5);
					item.y=row*(item.height+5);
					item.addEventListener(MouseEvent.MOUSE_DOWN,doSpendItem);
					item.addEventListener(MouseEvent.MOUSE_OVER,doMouseOverItem);
					item.addEventListener(MouseEvent.MOUSE_OUT,doMouseOutItem);
					panel.addChild(item);

				}

			}
			//for
		}
		private function doSpendItem(e:MouseEvent):void
		{
			var qty:Number=0;
		 
			for(var i:uint=0;i<items.length;i++)
			{
				if(items[i].id==e.target.name)
				{
					qty=items[i].qty;
					break
				}
			}
			//for		
			if(qty>0)
			{
				
				var battleEvt:BattleEvent=BattleScene.battleEvt;
				battleEvt.itemid=e.target.name;
				battleEvt.usedItemHandle();
			}
			//if
		}
		private function doMouseOverItem(e:MouseEvent):void
		{
			
		    //e.target.y+=10;
			TweenMax.to(e.target, 0.5, {dropShadowFilter:{color:0xffffff, alpha:1, blurX:10, blurY:10, distance:1},onComplete:onTweenComplete,onCompleteParams:[e.target]});
		}
		private function doMouseOutItem(e:MouseEvent):void
		{
			current_icon=e.target as MovieClip;
			TweenMax.to(e.target, 0.3, {dropShadowFilter:{color:0xffffff, alpha:0, blurX:0, blurY:0, distance:1},onComplete:onTweenComplete,onCompleteParams:[e.target]});
			 
		}
		private function onTweenComplete(target:*):void
		{
			TweenMax.killChildTweensOf(target);
		}
	}
}