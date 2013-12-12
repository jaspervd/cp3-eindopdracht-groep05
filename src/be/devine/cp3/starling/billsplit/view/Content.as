package be.devine.cp3.starling.billsplit.view {

import be.devine.cp3.starling.billsplit.view.screens.Overview;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import starling.display.Sprite;

public class Content extends Sprite {

    private var _navigator:ScreenNavigator;

    public function Content() {

        _navigator = new ScreenNavigator();
        addChild(_navigator);


        _navigator.addScreen("overview",new ScreenNavigatorItem( new Overview() ));
        _navigator.addScreen("detail",new ScreenNavigatorItem( new Overview() ));
        _navigator.addScreen("add",new ScreenNavigatorItem( new Overview() ));

        _navigator.showScreen("overview");


    }
}
}
