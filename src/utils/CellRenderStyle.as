package utils
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import fl.controls.listClasses.CellRenderer;
	import data.Config;
	public class CellRenderStyle extends CellRenderer
	{
		public function CellRenderStyle()
		{
			
			
		}
		override protected function drawLayout():void {
			//if(parseInt(this.listData.label)<0){
			//this.listData.label
			var format:TextFormat=new TextFormat();
			format.font=Config.ExcerptFornt;
			format.size=20;
			format.align="center";
			textField.textColor=0x000000;
			textField.setTextFormat(format);
			//}
			 
		 
			super.drawLayout();
		}
	}
}