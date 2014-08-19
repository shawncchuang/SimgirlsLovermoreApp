/**
 * Created by shawn on 2014-08-15.
 */
package controller {
import starling.display.Sprite;

public interface ViewInterface {

    function fullSizeCharacter(target:Sprite,params:Object=null):void
    function characterIcons(target:Sprite):void
    function skillIcons(target:Sprite):void
    function replaceCharacter(model:Sprite):void

}
}
