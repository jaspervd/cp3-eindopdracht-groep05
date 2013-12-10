package be.devine.cp3.starling.billsplit.view {

import be.devine.cp3.starling.billsplit.view.screens.Overview;

import starling.display.Sprite;

public class Content extends Sprite {
    private var _overview:Overview;

    public function Content() {

        _overview = new Overview();
        addChild(_overview);

    }
}
}
