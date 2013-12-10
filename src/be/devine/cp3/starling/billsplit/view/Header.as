package be.devine.cp3.starling.billsplit.view {


import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;

import starling.events.Event;

public class Header extends Screen{
    [Embed(source="/../assets/images/metalworks/menu_stripes_btn.png")]
    public static const MenuBtn:Class;

    [Embed(source="/../assets/images/metalworks/add_plus_btn.png")]
    public static const AddBtn:Class;

    private var _menu:Button;
    private var _multiple:Button;
    private var _quad:Quad;
    private var _header:feathers.controls.Header;

    public function Header() {


        _quad = new Quad(100,100);
        _quad.alpha = 0;

        _header = new feathers.controls.Header();
        _header.title = "Splits";
        addChild( _header );

        _menu = new Button();
        _menu.addEventListener(Event.TRIGGERED, menuClicked);

        _multiple = new Button();
        _multiple.addEventListener(Event.TRIGGERED, checkAction);



    }

    private function menuClicked(event:Event):void {


    }


    override protected function initialize():void{
        _menu.defaultIcon = Image.fromBitmap(new MenuBtn());
        _menu.iconPosition = Button.ICON_POSITION_LEFT;
        _menu.defaultSkin = _quad;
        _menu.upSkin = _quad;
        _menu.downSkin = _quad;

        _multiple.defaultIcon = Image.fromBitmap(new AddBtn());
        _multiple.iconPosition = Button.ICON_POSITION_LEFT;
        _multiple.defaultSkin = _quad;
        _multiple.upSkin = _quad;
        _multiple.downSkin = _quad;

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
