package be.devine.cp3.starling.billsplit.view.screens {

import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.service.PictureService;
import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.ImageLoader;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;
import flash.filesystem.File;
import starling.events.Event;


public class Register extends Screen {
    private var _appModel:AppModel;
    private var _personModel:PersonModel;
    private var _registerLayout:LayoutGroup;
    private var _pictureService:PictureService;
    private var _inputName:TextInput;
    private var _urlImage:String;
    private var _image:ImageLoader;

    public function Register() {
        _appModel = AppModel.getInstance();
        _personModel = PersonModel.getInstance();

        _registerLayout = new LayoutGroup();
        addChild(_registerLayout);

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 10;
        layout.paddingTop = 100;
        _registerLayout.layout = layout;

        _pictureService = new PictureService();
        _registerLayout.addChild(_pictureService);

        _urlImage = "";
        _image = new ImageLoader();
        _registerLayout.addChild(_image);

        var takePicBtn:Button = new Button();
        takePicBtn.label = "Take picture";
        takePicBtn.addEventListener(Event.TRIGGERED, takePictureHandler);
        _registerLayout.addChild(takePicBtn);

        _inputName = new TextInput();
        _inputName.prompt = "Name";
        _registerLayout.addChild(_inputName);

        var submitBtn:Button = new Button();
        submitBtn.label = "Save";
        _registerLayout.addChild(submitBtn);

        submitBtn.addEventListener(Event.TRIGGERED, buttonHandler);
    }

    private function takePictureHandler(event:Event):void {
        _registerLayout.removeChild(_pictureService);
        _urlImage = _pictureService.takePicture();

        var imgSrc:File = File.applicationStorageDirectory.resolvePath(_urlImage);
        _image.source = imgSrc.url;
    }

    override protected function initialize():void {
        layout();
    }

    private function layout():void {
        _pictureService.setSize(stage.stageWidth, stage.stageWidth * .75);
    }

    private function buttonHandler(event:Event):void {
        var error:Boolean = false;
        var alert:Alert;

        if (_urlImage.length == 0) {
            alert = Alert.show("Please take a picture", "Error", new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (_inputName.text.length == 0) {
            alert = Alert.show("Please fill in your name", "Error", new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }

        if (!error) {
            var personObj:Object = {};
            personObj.name = _inputName.text;
            personObj.image = _urlImage;
            personObj.moderator = true;
            personObj.iou = 0;

            _personModel.add(personObj);
            PersonService.write(_personModel.persons);

            _appModel.currentScreen = "add";
        }
    }
}
}
