package be.devine.cp3.starling.billsplit.view {


import be.devine.cp3.starling.billsplit.model.AppModel;
import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.Screen;
import feathers.controls.ScrollContainer;
import feathers.themes.MetalWorksMobileTheme;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;
import starling.events.Event;



public class Header extends ScrollContainer{


    [Embed(source="/../assets/images/metalworks/menu_stripes_btn.png")]
    public static const OverviewBtn:Class;

    [Embed(source="/../assets/images/back_btn.png")]
    public static const BackBtn:Class;

    [Embed(source="/../assets/images/metalworks/add_plus_btn.png")]
    public static const Multiple:Class;

    [Embed(source="/../assets/images/metalworks/transparent_repeat.png")]
    public static const Transparent:Class;

    private var _overview:Button;
    private var _multiple:Button;
    private var _quad:Quad;
    private var _header:feathers.controls.Header;
    private var _theme:MetalWorksMobileTheme;
    private var _action:String;
    private var _appmodel:AppModel;
    private var _back:Boolean;

    public function Header() {



        _appmodel = AppModel.getInstance();
        _theme = new MetalWorksMobileTheme();

        _header = new feathers.controls.Header();
        _header.title = "Splits";
        addChild( _header );

        _overview = new Button(); // backbutton
        _overview.nameList.add("overview");
        _overview.addEventListener(Event.TRIGGERED, overviewClicked);

        _multiple = new Button();
        _multiple.nameList.add("multiple");
        _multiple.addEventListener(Event.TRIGGERED, checkAction);



    }

    private function overviewClicked(event:Event):void {
        _appmodel.currentScreen = "overview";
    }

    override protected function initialize():void{


        _quad = new Quad(100,100);
        _quad.alpha = 0;


        _overview.defaultIcon = Image.fromBitmap(new OverviewBtn());
        _overview.iconPosition = Button.ICON_POSITION_LEFT;



        _multiple.defaultIcon = Image.fromBitmap(new Multiple());
        action = "add";
        _multiple.iconPosition = Button.ICON_POSITION_LEFT;



        _header.leftItems = new <DisplayObject>[ _overview ];
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
            break;


            case "remove feathers-header-item":

                trace("Remove");
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

    public function get back():Boolean {
        return _back;
    }

    public function set back(value:Boolean):void {
        _back = value;


        if(_back){
            _overview.defaultIcon = Image.fromBitmap(new BackBtn());
        }else{
            _overview.defaultIcon = Image.fromBitmap(new OverviewBtn());
        }


    }

    private function checkBack(event:Event):void {

        back = false;

        if(_appmodel.currentScreen !="overview"){

            back = true;

        }

    }
}
}
