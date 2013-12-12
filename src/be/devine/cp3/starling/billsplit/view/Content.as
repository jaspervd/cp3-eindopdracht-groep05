package be.devine.cp3.starling.billsplit.view {

import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.view.screens.Add;
import be.devine.cp3.starling.billsplit.view.screens.Detail;
import be.devine.cp3.starling.billsplit.view.screens.Overview;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import flash.events.Event;

import starling.display.Sprite;

public class Content extends Sprite {

    private var _navigator:ScreenNavigator;
    private var _appmodel:AppModel;

    public function Content() {


        _appmodel = AppModel.getInstance();

        _appmodel.addEventListener(Event.CHANGE,screenHandler);

        _navigator = new ScreenNavigator();
        addChild(_navigator);


        _navigator.addScreen("overview",new ScreenNavigatorItem( new Overview() ));
        _navigator.addScreen("detail",new ScreenNavigatorItem( new Detail() ));
        _navigator.addScreen("add",new ScreenNavigatorItem( new Add() ));

        _navigator.showScreen("overview");


    }

    private function screenHandler(event:Event):void {

        _navigator.showScreen(_appmodel.currentScreen);

    }
}
}
