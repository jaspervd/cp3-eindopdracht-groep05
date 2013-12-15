package be.devine.cp3.starling.billsplit.view {

import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.view.screens.Add;
import be.devine.cp3.starling.billsplit.view.screens.Detail;
import be.devine.cp3.starling.billsplit.view.screens.Overview;

import feathers.controls.Screen;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

import flash.events.Event;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.DisplayObject;


public class Content extends Screen {

    private var _navigator:ScreenNavigator;
    private var _appmodel:AppModel;
    protected var navigator:ScreenNavigator;

    public function Content() {


        _appmodel = AppModel.getInstance();

        _appmodel.addEventListener(Event.CHANGE,screenHandler);

        _navigator = new ScreenNavigator();
        addChild(_navigator);


        _navigator.addScreen("overview",new ScreenNavigatorItem( new Overview() ));
        _navigator.addScreen("detail",new ScreenNavigatorItem( new Detail() ));
        _navigator.addScreen("add",new ScreenNavigatorItem( new Add() ));

        var transitionManager:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(_navigator);
        transitionManager.ease = Transitions.EASE_IN_OUT;
        transitionManager.duration = .5;

        _navigator.showScreen("overview");

        this.navigator = _navigator;
    }

    private function screenHandler(event:Event):void {

        navigator.showScreen(_appmodel.currentScreen);
    }
}
}
