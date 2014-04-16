package views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import events.BattleEvent;
	
	import views.BattleScene;

	public class CommanderItemsPanel extends Sprite
	{
		private var itemspool:Object=new Object();
		private var flox:FloxInterface=new FloxCommand();
		private var panel:MovieClip;
		public function CommanderItemsPanel()
		{
			itemspool={"com0":new Itemcom0(),
				        "com1":new Itemcom1()
			
			}
		      initItemsPanel();	
			
		}
		private function initItemsPanel():void
		{
			 panel=new CommanderItems();
			 addChild(panel);
			
			var format:TextFormat=new TextFormat();
			format.font="Impact";
			format.size=16;
			format.color=0x000000;
			 var items:Array=flox.getPlayerData("items");
			 var index:Number=0;
			 for(var i:uint=0;i< items.length;i++)
			 {
				 
				// var name:String="libItem"+i;
				 var itemid:String=items[i].id;
				 var item:MovieClip=itemspool[itemid];
				 item.mouseChildren=false;
				 item.buttonMode=true;
				 item.qty.defaultTextFormat=format;
				 item.name=itemid;
				 item.qty.text="x"+items[i].qty;
				 item.x=index*item.width;
				 item.addEventListener(MouseEvent.MOUSE_DOWN,doSpendItem);
				 panel.addChild(item);
				 
				 index++;
			 }
			//for
		}
		private function doSpendItem(e:MouseEvent):void
		{
			var battleEvt:BattleEvent=BattleScene.battleEvt;
			battleEvt.itemid=e.target.name;
			battleEvt.usedItemHandle();
		}
	}
}