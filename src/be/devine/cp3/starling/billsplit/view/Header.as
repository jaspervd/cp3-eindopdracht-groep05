package be.devine.cp3.starling.billsplit.view {


import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;
import feathers.themes.MetalWorksMobileTheme;


import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;

import starling.events.Event;
import starling.textures.Texture;

public class Header extends Screen{
    [Embed(source="/../assets/images/metalworks/menu_stripes_btn.png")]
    public static const MenuBtn:Class;

    [Embed(source="/../assets/images/metalworks/add_plus_btn.png")]
    public static const Multiple:Class;

    [Embed(source="/../assets/images/metalworks/transparent_repeat.png")]
    public static const Transparent:Class;


    private var _menu:Button;
    private var _multiple:Button;
    private var _quad:Quad;
    private var _header:feathers.controls.Header;
    private var _theme:MetalWorksMobileTheme;

    public function Header() {

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
        _theme.setInitializerForClass(Button ,myCustomButtonInitializer,"menu");



        _multiple.defaultIcon = Image.fromBitmap(new Multiple());
        _multiple.iconPosition = Button.ICON_POSITION_LEFT;
        _theme.setInitializerForClass(Button ,myCustomButtonInitializer,"multiple");



        _header.leftItems = new <DisplayObject>[ _menu ];
        _header.rightItems = new <DisplayObject>[ _multiple ];
        _header.width = stage.stageWidth;


        _header.backgroundSkin = _quad;


        trace('init');
    }


    override protected function draw():void{

        _header.width = stage.stageWidth;

    }




    private function myCustomButtonInitializer( button:Button ):void
    {


        var texture:Texture = Texture.fromBitmap(new Transparent());


        button.defaultSkin = new Image(texture);
        button.downSkin =  new Image(texture);
        button.hoverSkin =  new Image(texture);

    }


    private function checkAction(event:Event):void {


    }
}
}
