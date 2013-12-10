/**
 * Created with IntelliJ IDEA.
 * User: test
 * Date: 9/12/13
 * Time: 13:41
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view {


import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import starling.display.DisplayObject;

import starling.events.Event;

public class Header extends Screen{

    private var _menu:Button;
    private var _multiple:Button;
    private var _headergroup:LayoutGroup;
    private var _header:feathers.controls.Header;

    public function Header() {

        _headergroup = new LayoutGroup();
        _headergroup.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreated);

        var layout:HorizontalLayout = new HorizontalLayout();
        _headergroup.layout = layout;

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

    private function groupCreated(event:Event):void {
        addChild(_headergroup);
        _header.addChild(_menu);
        _header.addChild(_multiple);
        trace('test gc');
    }

    private function menuClicked(event:Event):void {


    }


    override protected function initialize():void{
        addChild(_headergroup);

        _header.leftItems = new <DisplayObject>[ _menu ];
        _header.rightItems = new <DisplayObject>[ _multiple ];
        _header.width = stage.stageWidth;

        trace('init');
    }


    override protected function draw():void{

        _headergroup.width = stage.stageWidth;

        _menu.x = 10;
        _menu.y = 10;

        _multiple.x = stage.stageWidth - _multiple.width - 10;

    }

    private function checkAction(event:Event):void {


    }
}
}
