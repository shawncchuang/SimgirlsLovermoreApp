package utils
{
    import fl.containers.UILoader;
    import fl.controls.listClasses.ICellRenderer;
	import fl.controls.listClasses.CellRenderer;
    import fl.controls.listClasses.ListData;
    import fl.core.InvalidationType;
    import fl.data.DataProvider;
    import flash.events.Event;
    import flash.text.TextField;
    public class LoaderCellRenderer extends UILoader implements ICellRenderer {
        protected var _data:Object;
        protected var _listData:ListData;
        protected var _selected:Boolean;

        public function LoaderCellRenderer():void {
            super();
        }

        public function get data():Object {
            return _data;
        }
        public function set data(value:Object):void {
            _data = value;
            source = value.data;
		    maintainAspectRatio=true;
		
        }

        public function get listData():ListData {
            return _listData;
        }
        public function set listData(value:ListData):void {
            _listData = value;
            invalidate(InvalidationType.DATA);
            invalidate(InvalidationType.STATE);
        }

        public function get selected():Boolean {
            return _selected;
        }
        public function set selected(value:Boolean):void {
            _selected = value;
            invalidate(InvalidationType.STATE);
        }

        public function setMouseState(state:String):void {
        }
		 
    }
}
