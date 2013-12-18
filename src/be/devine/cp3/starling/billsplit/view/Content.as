package be.devine.cp3.starling.billsplit.view {

import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.view.drawer.DrawerView;
import be.devine.cp3.starling.billsplit.view.drawer.skin.DrawersExplorerTheme;
import be.devine.cp3.starling.billsplit.view.screens.Add;
import be.devine.cp3.starling.billsplit.view.screens.Detail;
import be.devine.cp3.starling.billsplit.view.screens.Overview;
import be.devine.cp3.starling.billsplit.view.screens.Register;
import feathers.controls.Drawers;
import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.events.FeathersEventType;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

import flash.events.Event;

import starling.animation.Transitions;


public class Content extends Drawers {

    private var _navigator:ScreenNavigator;
    private var _appmodel:AppModel;
    protected var navigator:ScreenNavigator;

    public function Content() {


        super();
        this.addEventListener(FeathersEventType.INITIALIZE, initializer);

    }



    private function onBack():void {

        _appmodel.currentScreen = "overview";

    }

    private function screenHandler(event:Event):void {

        navigator.showScreen(_appmodel.currentScreen);
    }

    private function changeDockMode(drawer:DrawerView, dockMode:String):void
    {
        switch(drawer)
        {
            case this.topDrawer:
            {
                this.topDrawerDockMode = dockMode;
                break;
            }
            case this.rightDrawer:
            {
                this.rightDrawerDockMode = dockMode;
                break;
            }
            case this.bottomDrawer:
            {
                this.bottomDrawerDockMode = dockMode;
                break;
            }
            case this.leftDrawer:
            {
                this.leftDrawerDockMode = dockMode;
                break;
            }
        }
    }


    private function initializer():void{



        _appmodel = AppModel.getInstance();

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

        _navigator.showScreen("overview");

        this.content = new Detail();

        //a drawer may be opened by dragging from the edge of the content
        //you can also set it to drag from anywhere inside the content
        //or you can disable gestures entirely and only open a drawer when
        //an event is dispatched by the content or by calling a function
        //on the drawer component to open a drawer programmatically.
        this.openGesture = Drawers.OPEN_GESTURE_DRAG_CONTENT_EDGE;

        this.content = _navigator;

        this.rightDrawerToggleEventType = Detail.TOGGLE_RIGHT_DRAWER;


        var optionsDrawer:DrawerView = new DrawerView("Right");
        optionsDrawer.nameList.add(DrawersExplorerTheme.THEME_NAME_LEFT_AND_RIGHT_DRAWER);
        optionsDrawer.addEventListener(DrawerView.CHANGE_DOCK_MODE_TO_NONE, drawer_dockNoneHandler);
        optionsDrawer.addEventListener(DrawerView.CHANGE_DOCK_MODE_TO_BOTH, drawer_dockBothHandler);
        this.rightDrawer = optionsDrawer;
        this.rightDrawerDockMode = Drawers.DOCK_MODE_NONE;

    }


    private function drawer_dockNoneHandler(event:Event):void
    {
        var drawer:DrawerView = DrawerView(event.currentTarget);
        this.changeDockMode(drawer, Drawers.DOCK_MODE_NONE);
    }

    private function drawer_dockBothHandler(event:Event):void
    {
        var drawer:DrawerView = DrawerView(event.currentTarget);
        this.changeDockMode(drawer, Drawers.DOCK_MODE_BOTH);
    }

}
}
