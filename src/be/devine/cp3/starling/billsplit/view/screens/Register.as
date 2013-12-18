/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 18/12/13
 * Time: 12:17
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.service.PictureService;

import feathers.controls.Alert;

import feathers.controls.Button;

import feathers.controls.LayoutGroup;

import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import flash.events.Event;

import starling.display.Sprite;
import starling.events.TouchEvent;

public class Register extends Screen {
    private var _appModel:AppModel;
    private var _personModel:PersonModel;
    private var _registerLayout:LayoutGroup;
    private var _pictureService:PictureService;
    private var _inputName:TextInput;
    private var _submitBtn:Button;

    public function Register() {
        _appModel = AppModel.getInstance();
        _personModel = PersonModel.getInstance();

        _registerLayout = new LayoutGroup();
        addChild(_registerLayout);

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 15;
        layout.paddingTop = 100;
        _registerLayout.layout = layout;

        /*_pictureService = new PictureService();
        _pictureService.addEventListener(TouchEvent.TOUCH, pictureTriggeredHandler);
        _pictureService.height = this.width * .75;
        _registerLayout.addChild(_pictureService);*/

        _inputName = new TextInput();
        _inputName.prompt = "Name";
        _registerLayout.addChild(_inputName);

        _submitBtn = new Button();
        _submitBtn.label = "Save";
        _registerLayout.addChild(_submitBtn);

        _submitBtn.addEventListener(Event.TRIGGERED, buttonHandler);
    }

    private function pictureTriggeredHandler(event:TouchEvent):void {
        _registerLayout.removeChild(_pictureService);
        _registerLayout.addChild(_pictureService.screenShot as Sprite);
    }

    private function buttonHandler(event:Event):void {
        var error:Boolean = false;
        var alert:Alert;

        if (_inputName.text.length == 0) {
            alert = Alert.show("Please fill in your name", "Error", new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }


        if (!error) {
            var personObj:Object = {};
            personObj.name = _inputName.text;
            personObj.moderator = true;

            _personModel.add(personObj);
            PersonService.write(_personModel.persons);

            _appModel.currentScreen = "overview";
        }
    }
}
}
