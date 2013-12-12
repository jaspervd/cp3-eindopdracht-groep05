package be.devine.cp3.starling.billsplit.view {


import be.devine.cp3.starling.billsplit.model.AppModel;

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.Screen;
import feathers.themes.MetalWorksMobileTheme;



import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;

import starling.events.Event;

public class Header extends Screen{
    [Embed(source="/../assets/images/metalworks/menu_stripes_btn.png")]
    public static const MenuBtn:Class;

    [Embed(source="/../assets/images/metalworks/add_plus_btn.png")]
    public static const Multiple:Class;


    public static var NAVIGATE_ADD:String = "NAVIGATE_ADD";
    public static var NAVIGATE_REMOVE:String = "NAVIGATE_ADD";


    private var _menu:Button;
    private var _multiple:Button;
    private var _quad:Quad;
    private var _header:feathers.controls.Header;
    private var _theme:MetalWorksMobileTheme;
    private var _action:String;
    private var _appmodel:AppModel;

    public function Header() {

        _appmodel = AppModel.getInstance();

        _theme = new MetalWorksMobileTheme();

        _header = new feathers.controls.Header();
        _header.title = "Splits";
        addChild( _header );

        _menu = new Button();
        _menu.nameList.add("menu");
        _menu.addEventListener(Event.TRIGGERED, menuClicked);

        _multiple = new Button();
        _multiple.nameList.add("multiple");
        _multiple.addEventListener(Event.TRIGGERED, checkAction);



    }

    private function menuClicked(event:Event):void {


    }


    override protected function initialize():void{


        _quad = new Quad(100,100);
        _quad.alpha = 0;


        _menu.defaultIcon = Image.fromBitmap(new MenuBtn());
        _menu.iconPosition = Button.ICON_POSITION_LEFT;



        _multiple.defaultIcon = Image.fromBitmap(new Multiple());
        action = "add";
        _multiple.iconPosition = Button.ICON_POSITION_LEFT;



        _header.leftItems = new <DisplayObject>[ _menu ];
        _header.rightItems = new <DisplayObject>[ _multiple ];
        _header.width = stage.stageWidth;
        _header.height = stage.stageHeight*.1;


        _header.backgroundSkin = _quad;




        trace('[HEADER]');
    }


    override protected function draw():void{

        _header.width = stage.stageWidth;

    }


    private function checkAction(event:Event):void {

        var currentButton:Button = Button(event.target);

        trace(currentButton.name);

        switch (currentButton.name){

            case "add feathers-header-item":

                    trace("add");
                    _appmodel.currentScreen = "add";

                    dispatchEvent(new Event(NAVIGATE_ADD));
            break;


            case "remove feahters-header-item":

                trace("Remove");

                dispatchEvent(new Event(NAVIGATE_REMOVE));
            break;

        }


    }

    public function get action():String {
        return _action;
    }

    public function set action(value:String):void {

       if(_action != value){

           _action = value;

           _multiple.name = _action;
       }
    }
}
}
