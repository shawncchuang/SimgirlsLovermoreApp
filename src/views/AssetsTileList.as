
package views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import data.DataContainer;
	
	import fl.containers.UILoader;
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	import fl.events.DataGridEvent;
	
	import model.SaveGame;
	
	import starling.display.Sprite;
	
	import utils.AlternatingRowColors;
	import utils.CellRenderStyle;
	import utils.DebugTrace;
	import utils.HeaderRenderStyle;
	import utils.LoaderCellRenderer;
	import utils.ViewsContainer;
	
	public class AssetsTileList extends flash.display.Sprite
	{
		private var _type:String;
		private var selectable:Boolean=false;
		private var chname:String="";
		private var assetstags:AssetsTagIcon;
		private var flox:FloxInterface=new FloxCommand();
		private var experptbox:MovieClip;
		private var datagrid:DataGrid ;
		private var dp:DataProvider;
		private var posX:Number=0;
		private var posY:Number=0;
		private var assetsData:Object;
		private var ownedAssets:Array;
		private var assetslist:Array
		private var tag_names:Array=["consumable","misc","apparel","estatecar"];
		private var catelist:Array=["cons","misc","app","est"];
		private var cate:String="";
		private var tag_index:Number=0;
		private var itemscon:UILoader;
		private var item_id:String;
		
		public function AssetsTileList(type:String)
		{
			_type=type;
			if(_type!="assets_form")
			{
				selectable=true;
				
			}
			init()
			
		}
		private function init():void
		{
			
			chname=ProfileScene.CharacterName;
			assetsData=flox.getSyetemData("assets");
			var savedata:SaveGame=FloxCommand.savegame;
			ownedAssets=savedata.owned_assets[chname];
			//DebugTrace.msg("AssetsTileList.init chname:"+chname);
			
			
			initAssetsGrid();
			initAssetsTag()
			if(ownedAssets.length==0)
			{
				try
				{
				var profileScene:starling.display.Sprite= ViewsContainer.ExcerptBox;
				profileScene.dispatchEventWith("CLEAR");
				}
				catch(e:Error)
				{
					DebugTrace.msg("AssetsTileList.init No Assets");
				}
		    }
			
		}
		private function initAssetsGrid():void
		{
			
			
			
			//DebugTrace.msg("AssetsTileList.init assetsIDs:"+assetsIDs.toString())
			assetslist=new Array();
			var gridObj:Object=new Object();
			dp = new DataProvider();
			dp.removeAll();
			for(var i:uint=0;i<ownedAssets.length;i++)
			{
				var id:String=ownedAssets[i].id;
				var _cate:String=ownedAssets[i].cate;
				gridObj[id]=assetsData[id];
				//DebugTrace.obj("AssetsTileList.init id:"+id);
				var item:Object=gridObj[id];
				//DebugTrace.obj("AssetsTileList.init cate:"+item.cate);
				item.id=id;
				item.qty=ownedAssets[i].qty;
				assetslist.push(item);
				dp.addItem(item);
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
			
			var c2:DataGridColumn = new DataGridColumn("brand");
			c2.headerText="Brand";
			c2.cellRenderer=CellRenderStyle;
			c2.headerRenderer=HeaderRenderStyle;
			c2.sortOptions = Array.NUMERIC;
			
			var c3:DataGridColumn = new DataGridColumn("price");
			c3.headerText="Price";
			c3.cellRenderer=CellRenderStyle;
			c3.headerRenderer=HeaderRenderStyle;
			c3.sortOptions = Array.NUMERIC;
			
			
			var c4:DataGridColumn = new DataGridColumn("qty");
			c4.headerText="Qty";
			c4.cellRenderer=CellRenderStyle;
			c4.headerRenderer=HeaderRenderStyle;
			c4.sortOptions = Array.NUMERIC;
			
			
			datagrid= new DataGrid();
			datagrid.resizableColumns=true;
			datagrid.selectable=selectable;
			datagrid.addColumn(dataCol);
			datagrid.addColumn(c1);
			datagrid.addColumn(c2);
			datagrid.addColumn(c3);
			datagrid.addColumn(c4);
			datagrid.dataProvider = dp;
			datagrid.setSize(560,405);
			datagrid.headerHeight=30;
			datagrid.rowHeight =60;
			//datagrid.rowCount = dp.length - 1;
			datagrid.move(406, 225);
			//datagrid.addEventListener(DataGridEvent.HEADER_RELEASE, headerReleaseHandler);
			
			if(ownedAssets.length>0)
			{
				
				datagrid.addEventListener(Event.CHANGE, onChangeItemHandler);
				datagrid.addEventListener(MouseEvent.CLICK, onClickItemHandler);
				datagrid.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverItemHandler);
			}
			//datagrid.addEventListener(MouseEvent.ROLL_OUT, onMouseOutItemHandler);
			datagrid.setStyle("cellRenderer", AlternatingRowColors);
			addChild(datagrid);
			//showExcerptBox();
			function headerReleaseHandler(event:DataGridEvent):void {
				var myDG:DataGrid = event.currentTarget as DataGrid;
				var whichColumn:DataGridColumn = myDG.getColumnAt(event.columnIndex);
				DebugTrace.msg("sortDescending:"+ myDG.sortDescending);
				DebugTrace.msg("sortIndex:"+ myDG.sortIndex);
				DebugTrace.msg("dataField:"+ whichColumn.dataField);
				DebugTrace.msg("");
			}
			
		}
		private function onChangeItemHandler(e:Event):void
		{
			item_id=e.target.selectedItem.id
			
		}
		private function onClickItemHandler(e:MouseEvent):void
		{
			
			DebugTrace.msg("AssetsTileList.onClickItemHandler:");
			if(_type=="dating_assets_form")
			{
				var assets:Object=flox.getSyetemData("assets");
				 
				var assets_item:Object=assets[item_id];
				 
				itemscon=new UILoader();
				itemscon.source=assets_item.data;
				itemscon.width=60;
				itemscon.height=60;
				itemscon.x=this.mouseX-itemscon.width/2;
				itemscon.y=this.mouseY-itemscon.height/2;
				addChild(itemscon);
				itemscon.addEventListener(Event.ENTER_FRAME,doItemMoving);
				
				sentItemHandler();
				
			}
			//if
		}
		private function sentItemHandler():void
		{
			//sent item to someone
			var sysAssets:Object=flox.getSyetemData("assets");
			var owned_assets:Object=flox.getSaveData("owned_assets");
			var assetslist:Array=owned_assets.player;
			var dating:String=DataContainer.currentDating;
			var datingItems:Array=owned_assets[dating];
			var index:Number=searchID(assetslist,item_id);
			DebugTrace.msg("AssetsTileList.sentItemHandler  dating:"+dating+" ;item_id:"+item_id)
			var qty:Number=assetslist[index].qty;
			qty--;
			if(qty==0)
			{
			
				var _assetslist:Array=assetslist.splice(index);
				_assetslist.shift();
				var new_assetslist:Array=assetslist.concat(_assetslist);
				/*for(var j:uint=0;j<new_assetslist.length;j++)
				{
					DebugTrace.msg("AssetsTileList.sentItemHandler   assetslist:"+JSON.stringify(new_assetslist[j]));
				}
				//for*/
				owned_assets.player=new_assetslist;
			}
			else
			{
				assetslist[index].qty=qty;
				owned_assets.player=assetslist;
				
			}
			var index1:Number=searchID(datingItems,item_id);
			var obsloete:Number=Number(sysAssets[item_id].obsoleteIn);
			if(index1==-1)
			{
				//dating person didn't have this item
				var new_item:Object=new Object();
				new_item.id=item_id;
				new_item.qty=1;
				new_item.obsoleteIn=obsloete;
				datingItems.push(new_item);
				
			}
			else
			{
				datingItems[index1].obsoleteIn=obsloete;
				qty=datingItems[index1].qty;
				qty++;
				datingItems[index1].qty=qty;
			}
			//if
		
			owned_assets[dating]=datingItems;
			var savegame:SaveGame= FloxCommand.savegame;
			savegame.owned_assets=owned_assets;
			FloxCommand.savegame=savegame;
			
			removeChild(datagrid);
			removeChild(assetstags);
			init();
		}
		private function searchID(list:Array,item_id:String):Number
		{
			var index:Number=-1;
			for(var i:uint=0;i<list.length;i++)
			{
				var id:String=list[i].id;
				if(item_id==id)
				{
					index=i;
					break
				}
				//if
			}
			//for
			return index
		}
		private function doItemMoving(e:Event):void
		{
			
			var posX:Number=((130-itemscon.width/2)-e.target.x)*.2;
			var posY:Number=((127-itemscon.height/2)-e.target.y)*.2;
			e.target.x+=posX;
			e.target.y+=posY;
			//DebugTrace.msg("AssetsTileList.doItmeMoving:"+posX+" ; "+posY);
			if(uint(posX)==0 && uint(posY)==0)
			{
				itemscon.removeEventListener(Event.ENTER_FRAME,doItemMoving);
				removeChild(itemscon);
				var _data:Object=new Object();
				_data.com="GotGift";
				_data.item_id=item_id;
				var basesprite:starling.display.Sprite=ViewsContainer.baseSprite;
				basesprite.dispatchEventWith("commit",false,_data);
			}
		}
		private function onMouseOverItemHandler(e:MouseEvent):void
		{
			var profileScene:starling.display.Sprite= ViewsContainer.ExcerptBox;
			try
			{
				var id:String=e.target.data.id
				//DebugTrace.msg("onMouseOverItemHandler:"+ id);
				
				var assets:Object=flox.getSyetemData("assets");
				var assets_item:Object=assets[id]
				//DebugTrace.msg(assets_item.cate);
				var _data:Object=new Object();
				_data.id=id
				profileScene.dispatchEventWith("UPDATE",false,_data);
				
			}
			catch(err:Error)
			{
				//DebugTrace.msg("onMouseOverItemHandler Error");
				profileScene.dispatchEventWith("CLEAR");
			}
		}
		private function onMouseOutItemHandler(e:MouseEvent):void
		{
			
			try
			{
				var id:String=e.target.data.id
				cate=e.target.data.cate;
				//DebugTrace.msg("onMouseOutItemHandler:"+ cate);
			}
			catch(err:Error)
			{
				//DebugTrace.msg("onMouseOutItemHandler Error");
				
			}
		}
		private function initAssetsTag():void
		{
			assetstags=new AssetsTagIcon();
			for(var i:uint=0;i<tag_names.length;i++)
			{
				var tag:MovieClip=assetstags[tag_names[i]] as MovieClip;
				tag.buttonMode=true;
				
				
			}
			assetstags.x=713;
			assetstags.y=165;
			if(ownedAssets.length>0)
			{		
				assetstags.addEventListener(MouseEvent.CLICK,doSelectedCate);
			}
			addChild(assetstags);
			disableTag();
		}
		private function disableTag():void
		{
			
			for(var i:uint=0;i<tag_names.length;i++)
			{
				var tag:MovieClip=assetstags[tag_names[i]] as MovieClip;
				tag.alpha=0.5;
				
				
			}
			assetstags[tag_names[tag_index]].alpha=1;
			
			
		}
		private function doSelectedCate(e:MouseEvent):void
		{
			var target:MovieClip=e.target as MovieClip;
			catelist=["cons","misc","app","est"];	
			tag_index=tag_names.indexOf(target.name);
			cate=this.catelist[tag_index];
			DebugTrace.msg("AssetsTileList.doSelectedCate target.name: "+target.name+" ; cate:"+cate)
			//datagrid.sortItemsOn("cate","misc");
			//removeChild(datagrid);
			//initAssetsGrid();
			disableTag();
			resetDataProvider();
			
			
		}
		private function resetDataProvider():void
		{
			catelist=["cons","misc","app","est"];
			var _catelist:Array=catelist.splice(tag_index);
			_catelist.shift();
			var new_catelist:Array=catelist.concat(_catelist);
			new_catelist.unshift(cate);
			DebugTrace.obj("AssetsTileList.resetDataProvider new_catelist:"+new_catelist);
			var gridObj:Object=new Object();
			dp = new DataProvider();
			dp.removeAll();
			
			for(var j:uint=0;j<new_catelist.length;j++)
			{
				for(var i:uint=0;i<assetslist.length;i++)
				{
					var item_cate:String=assetslist[i].cate;
					//trace(item_cate," ; ",new_catelist[j])
					if(item_cate==new_catelist[j])
					{
						
						dp.addItem(assetslist[i]);
					}
					//if
					
				}
				//for
			}
			//for
			removeChild(datagrid);
			initDataGrid();
		}
		/*private function showExcerptBox():void
		{
		experptbox=new ExcerptBox();
		experptbox.txt.text="TEsdfMKfdsfsdM:LKLNFLKNLDNFLFSDLLSD;h"
		experptbox.addEventListener(Event.ENTER_FRAME,doMovingBox);
		addChild(experptbox);
		}
		private function doMovingBox(e:Event):void
		{
		posX=this.mouseX-experptbox.width/2;
		posY=this.mouseY-experptbox.height
		experptbox.x+=(posX-experptbox.x)*.5;
		experptbox.y+=(posY-experptbox.y)*.5;
		}*/
	}
}