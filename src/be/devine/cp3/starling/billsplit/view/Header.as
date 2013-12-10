package be.devine.cp3.starling.billsplit.view {


import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import starling.display.DisplayObject;
import starling.display.Quad;

import starling.events.Event;

public class Header extends Screen{

    private var _menu:Button;
    private var _multiple:Button;
    private var _headergroup:LayoutGroup;
    private var _quad:Quad;
    private var _header:feathers.controls.Header;

    public function Header() {


        _quad = new Quad(10,10);
        _quad.alpha = 0;

        _header = new feathers.controls.Header();
        _header.title = "Splits";
        addChild( _header );

        _menu = new Button();
        _menu.label = "Menu";
        _menu.addEventListener(Event.TRIGGERED, menuClicked);

        _multiple = new Button();
        _multiple.label = "Add";
        _multiple.addEventListener(Event.TRIGGERED, checkAction);



    }

    private function menuClicked(event:Event):void {


    }


    override protected function initialize():void{

        _header.leftItems = new <DisplayObject>[ _menu ];
        _header.rightItems = new <DisplayObject>[ _multiple ];
        _header.width = stage.stageWidth;
        _header.backgroundSkin = _quad;

        trace('init');
    }


    override protected function draw():void{

        _header.width = stage.stageWidth;

    }

    private function checkAction(event:Event):void {


    }
}
}
