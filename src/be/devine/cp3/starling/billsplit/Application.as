package be.devine.cp3.starling.billsplit {

import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.view.Header;

import feathers.themes.MinimalMobileTheme;

import starling.display.Sprite;
import starling.events.Event;

public class Application extends Sprite {
    private var _appModel:AppModel;
    private var header:Header;

    public function Application() {
        new MinimalMobileTheme(); // custom theme later?
        _appModel = AppModel.getInstance();
        _appModel.load();

        addEventListener(Event.ADDED_TO_STAGE, addedHandler);

    }

    private function closeHandler(event:Event):void {
        _appModel.closeApp();
    }

    private function addedHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(Event.RESIZE, resizeHandler);
        stage.addEventListener(Event.CLOSE, closeHandler);
        layout();
    }

    private function resizeHandler(event:Event):void {
        layout();
    }

    private function layout():void {

        header = new Header();
        addChild(header);

    }
}
}
