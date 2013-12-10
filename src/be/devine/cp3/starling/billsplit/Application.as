package be.devine.cp3.starling.billsplit {

import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.view.Content;
import be.devine.cp3.starling.billsplit.view.Header;


import feathers.themes.MetalWorksMobileTheme;

import starling.display.Sprite;
import starling.events.Event;

public class Application extends Sprite {
    private var _appModel:AppModel;
    private var _personModel:PersonModel;
    private var header:Header;
    private var content:Content;
    private var _theme:MetalWorksMobileTheme;

    public function Application() {
        _theme = new MetalWorksMobileTheme();

        _appModel = AppModel.getInstance();
        _appModel.load();

        _personModel = PersonModel.getInstance();

        addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }

    private function completeHandler(event:Event):void {
        trace('complete');
        _personModel.persons = _appModel.persons;
    }

    private function closeHandler(event:Event):void {
        _appModel.closeApp();
    }

    private function addedHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(Event.RESIZE, resizeHandler);
        stage.addEventListener(Event.CLOSE, closeHandler);
        this.addEventListener(AppModel.COMPLETE_BITCH, completeHandler);
        layout();
    }

    private function resizeHandler(event:Event):void {
        layout();
    }

    private function layout():void {

        content = new Content();
        addChild(content);

        header = new Header();
        addChild(header);

    }
}
}
