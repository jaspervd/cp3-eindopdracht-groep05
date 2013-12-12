/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 12/12/13
 * Time: 16:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;

import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Radio;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.core.ToggleGroup;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import starling.events.Event;

public class Add extends Screen {
    private var _addLayout:LayoutGroup;
    private var _inputTitle:TextInput;
    private var _inputPrice:TextInput;
    private var _submitBtn:Button;
    private var _appModel:AppModel;
    private var _taskModel:TaskModel;
    private var _personModel:PersonModel;
    private var _group:ToggleGroup;

    public function Add() {
        _appModel = AppModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _personModel = PersonModel.getInstance();

        _addLayout = new LayoutGroup();
        addChild(_addLayout);

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 15;
        layout.paddingTop = 100;
        _addLayout.layout = layout;

        _inputTitle = new TextInput();
        _inputTitle.prompt = "Title";
        _addLayout.addChild(_inputTitle);

        _inputPrice = new TextInput();
        _inputPrice.prompt = "Price";
        _inputPrice.restrict = "0-9^.";
        _addLayout.addChild(_inputPrice);

        _group = new ToggleGroup();

        var radio1:Radio = new Radio();
        radio1.label = "Restaurant";
        radio1.toggleGroup = _group;
        _group.selectedItem = radio1;
        _addLayout.addChild(radio1);

        var radio2:Radio = new Radio();
        radio2.label = "Bar";
        radio2.toggleGroup = _group;
        _addLayout.addChild(radio2);

        var radio3:Radio = new Radio();
        radio3.label = "Shop";
        radio3.toggleGroup = _group;
        _addLayout.addChild(radio3);

        _submitBtn = new Button();
        _submitBtn.label = "Save";
        _addLayout.addChild(_submitBtn);

        _submitBtn.addEventListener(Event.TRIGGERED, buttonHandler);
    }

    private function buttonHandler(event:Event):void {
        var alert:Alert = Alert.show("This is an alert!", "Hello World", new ListCollection([{ label: "OK" }]));
    }
}
}
