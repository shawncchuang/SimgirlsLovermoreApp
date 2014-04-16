package utils
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import data.Config;
	
	import fl.controls.dataGridClasses.HeaderRenderer;
	 

	public class HeaderRenderStyle extends HeaderRenderer
	{
		private var format:TextFormat;
		public function HeaderRenderStyle()
		{
			init();
		}
		private function init():void
		{
			format=new TextFormat();
			format.font=Config.ExcerptFornt;
			format.color=0x000000;
			format.size=15;
			format.align=TextFormatAlign.CENTER;
			
		}
		override protected function drawLayout():void
		{
			
			super.drawLayout();
			//if(parseInt(this.listData.label)<0){
			//this.listData.label
			
			//textField.textColor=0x000000;]
		 
			textField.width=this.width;
			textField.height=this.height;
			textField.setTextFormat(format);
			//}
			
			
		}
	}
}