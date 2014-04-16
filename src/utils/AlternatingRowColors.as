package utils
{
    import fl.controls.listClasses.CellRenderer;
    import fl.controls.listClasses.ICellRenderer;

    public class AlternatingRowColors extends CellRenderer implements ICellRenderer {

        public function AlternatingRowColors():void {
            super();
        }

        public static function getStyleDefinition():Object {
            return CellRenderer.getStyleDefinition();
        }

        override protected function drawBackground():void {
           /* if (_listData.index % 2 == 0) {
                setStyle("upSkin", CellRenderer_upSkinGray);
            } else {
                setStyle("upSkin", CellRenderer_upSkinDarkGray);
            }*/
			setStyle("upSkin", CellRenderer_upSkinGray);
            super.drawBackground();
        }
    }
}
