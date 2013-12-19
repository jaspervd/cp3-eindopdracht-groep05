package be.devine.cp3.starling.billsplit.view {

import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.view.screens.Add;
import be.devine.cp3.starling.billsplit.view.screens.Detail;
import be.devine.cp3.starling.billsplit.view.screens.Overview;
import be.devine.cp3.starling.billsplit.view.screens.Register;
import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.controls.ScrollContainer;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
import starling.animation.Transitions;
import starling.events.Event;


public class Content extends ScrollContainer {
    private var _navigator:ScreenNavigator;
    private var _appmodel:AppModel;
    private var _personModel:PersonModel;
    protected var navigator:ScreenNavigator;

    public function Content() {
        _appmodel = AppModel.getInstance();
        _personModel = PersonModel.getInstance();

        _appmodel.addEventListener(Event.CHANGE,screenHandler);

        _navigator = new ScreenNavigator();
        addChild(_navigator);

        _navigator.addScreen("register",new ScreenNavigatorItem( new Register() ));
        _navigator.addScreen("overview",new ScreenNavigatorItem( new Overview() ));
        _navigator.addScreen("detail",new ScreenNavigatorItem( new Detail() ));
        _navigator.addScreen("add",new ScreenNavigatorItem( new Add() ));

        var transitionManager:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(_navigator);
        transitionManager.ease = Transitions.EASE_IN_OUT;
        transitionManager.duration = .5;

        if(_personModel.getModerator() == null) {
            _navigator.showScreen("register");
        } else {
            _navigator.showScreen("overview");
        }

        this.navigator = _navigator;

    }

    private function onBack():void {

        _appmodel.currentScreen = "overview";

    }

    private function screenHandler(event:Event):void {
        trace('screenhandler');
        navigator.showScreen(_appmodel.currentScreen);
    }
}
}
