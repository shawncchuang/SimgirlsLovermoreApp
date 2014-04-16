package views
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	//import flash.net.URLRequest;
	//import flash.net.navigateToURL;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.Config;
	
	import events.GameEvent;
	import events.SceneEvent;
	
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	
	import services.LoaderRequest;
	
	import starling.display.Sprite;
	
	import utils.AlternatingRowColors;
	import utils.CellRenderStyle;
	import utils.DebugTrace;
	import utils.HeaderRenderStyle;
	import utils.LoaderCellRenderer;
	import utils.ViewsContainer;
	
	public class BlackTileList extends flash.display.Sprite
	{
		private var flox:FloxInterface=new FloxCommand();
		private var dp:DataProvider;
		private var itemlist:Array;
		private var marketlist:Object;
		private var selectable:Boolean=false;
		private var datagrid:DataGrid;
		private var item_id:String;
		public function BlackTileList()
		{
			initListData();
		}
		private function initListData():void
		{
			marketlist=flox.getSyetemData("blackmarket");
			itemlist=new Array();
			var itemdata:Object=new Object();
			dp = new DataProvider();
			for(var id:String in marketlist)
			{
				itemdata[id]=marketlist[id];
				var item:Object=itemdata[id];
				item.id=id;
				dp.addItem(item);
				itemlist.push(item);
			}
			//for
			
			initDataGrid();
		}
		private function initDataGrid():void
		{
			var dataCol:DataGridColumn = new DataGridColumn("data");
			dataCol.headerText="Pic";
			dataCol.cellRenderer = LoaderCellRenderer;
			dataCol.headerRenderer=HeaderRenderStyle;
			
			
			var c1:DataGridColumn = new DataGridColumn("name");
			c1.headerText="Name";
			c1.cellRenderer=CellRenderStyle;
			c1.headerRenderer=HeaderRenderStyle;
			
			var c2:DataGridColumn = new DataGridColumn("price");
			c2.headerText="Price";
			c2.cellRenderer=CellRenderStyle;
			c2.headerRenderer=HeaderRenderStyle;
			c2.sortOptions = Array.NUMERIC;
			
			
			
			
			datagrid= new DataGrid();
			datagrid.resizableColumns=true;
			datagrid.selectable=selectable;
			datagrid.addColumn(dataCol);
			datagrid.addColumn(c1);
			datagrid.addColumn(c2);
			datagrid.dataProvider = dp;
			datagrid.x=470;
			datagrid.y=189;
			datagrid.setSize(460,430);
			datagrid.headerHeight=30;
			datagrid.rowHeight =60;
			
			if(itemlist.length>0)
			{
				
				datagrid.addEventListener(Event.CHANGE, onChangeItemHandler);
				datagrid.addEventListener(MouseEvent.CLICK, onClickItemHandler);
				datagrid.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverItemHandler);
			}
			//if
			
			datagrid.setStyle("cellRenderer", AlternatingRowColors);
			addChild(datagrid);
			
		}
		private function onChangeItemHandler(e:Event):void
		{
			
			item_id=e.target.selectedItem.id
			
			
		}
		private function onClickItemHandler(e:MouseEvent):void
		{
			item_id=e.target.data.id;
			
			flox.refreshPlayer(onRefreshComplete);
			
			
		}
		private function onRefreshComplete():void
		{
			try
			{
				var coin:Number=flox.getPlayerData("coin");
				
				DebugTrace.msg("BlackTileList onClickItemHandler item_id:"+item_id);
				var price:Number=Number(marketlist[item_id].price);
				DebugTrace.msg("BlackTileList onClickItemHandler coin:"+coin+" ; price:"+price);
				var _data:Object=new Object();
				if(coin>=price)
				{
					//enough pay this item
					
					_data.price=price;
					var blackmarkerform:starling.display.Sprite=ViewsContainer.blackmarketform
					blackmarkerform.dispatchEventWith("UPDAT_BLANCE",false,_data);
					
				}
				else
				{
					var loaderreq:LoaderRequest=new LoaderRequest();
					loaderreq.paymentWeb("coin");
					
					/*var  authKey:String=flox.getPlayerData("authId");
					var url:String=Config.payCoinURL+authKey;
					DebugTrace.msg("BlackTileList onClickItemHandler url:"+url);
					var req:URLRequest=new URLRequest(url);
					navigateToURL(req,"_blank");*/
					
					var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
					gameEvent._name="remove_blackmarket_form";
					gameEvent.displayHandler();
					
					var command:MainInterface=new MainCommand();
					_data.name="BlackMarketScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					
					
				}
				//if
			}
			catch(e:Error)
			{
				
				
				DebugTrace.msg("BlackTileList onClickItemHandler ERROR:"+item_id);
				
				
			}
			
		}
		private function onMouseOverItemHandler(e:MouseEvent):void
		{
			
			var profileScene:starling.display.Sprite= ViewsContainer.ExcerptBox;
			try
			{
				var id:String=e.target.data.id
				var _data:Object=new Object();
				_data.id=id;
				_data.attr="blackmarket";
				profileScene.dispatchEventWith("UPDATE",false,_data);
			}
			catch(e:Error)
			{
				
				profileScene.dispatchEventWith("CLEAR");
			}
		}
	}
}