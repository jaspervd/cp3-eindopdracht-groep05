/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 28/11/13
 * Time: 16:54
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit {
import be.devine.cp3.starling.billsplit.model.AppModel;

import feathers.themes.MinimalMobileTheme;

import flash.events.Event;

import starling.display.Sprite;

public class Application extends Sprite {
    private var _appModel:AppModel;

    public function Application() {
        new MinimalMobileTheme(); // custom theme later?
        _appModel = AppModel.getInstance();
        _appModel.load();

        addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(Event.RESIZE, resizeHandler);
        layout();
    }

    private function resizeHandler(event:Event):void {
        layout();
    }

    private function layout():void {
        // x, y, width & height waardes
    }
}
}
