package views
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import controller.MemebersCommand;
	
	import events.BattleEvent;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	import views.BattleScene;
	
	public class EffectTapView extends EffectTap
	{
		private var _name:String;	
		private var count:Number=0;
		private var max:Number=0;
		private var member:Member;
	
		public function EffectTapView(name:String)
		{
			
			super();
			super.tap_name=name;
			super.init();
			init();
			
			
		}
		
		private function init():void
		{
			//DebugTrace.msg("DizzyTapView.onClickDizzyTap type="+ super.name+" ,name:"+this.name);
			
			
			max=Math.floor(Math.random()*20)+10;
			super.buttonMode=true;
			
			if(name.indexOf("player")!=-1)
			{
				super.addEventListener(MouseEvent.CLICK,onClickDizzyTap);
			}
		}
		
		private function onClickDizzyTap(e:MouseEvent):void
		{
			if(BattleScene.fighting)
			{
				count++;
				if(count>=max)
				{
					//var effect:String=e.target.split("_")[0];
					var id:String=e.target.name.split("_")[1];
					var battleteam:Object=ViewsContainer.battleteam;
					var member:Member=battleteam[id];
					member.removeClickTap();
					
					/*var memberEvt:BattleEvent=member.memberEvt;
					memberEvt.act="stand";
					memberEvt.updateMemberAct();*/
					
					
					
				}
				//if
			}
			//if
			DebugTrace.msg("DizzyTapView.onClickDizzyTap: "+ e.target.name+"; count:"+count+"; max="+max+"; fighting="+BattleScene.fighting);
			
		}
	}
}