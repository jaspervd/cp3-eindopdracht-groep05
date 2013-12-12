/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 12/12/13
 * Time: 16:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.vo.PersonVO;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

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
    private var _arrTypes:Array;

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

        _group = new ToggleGroup();
        _arrTypes = ["Other", "Restaurant", "Bar", "Shop"];

        for each(var type:String in _arrTypes) {
            var radio:Radio = new Radio();
            radio.label = type;
            radio.toggleGroup = _group;
            if (type == "Other") {
                _group.selectedItem = radio;
            }
            _addLayout.addChild(radio);
        }

        _inputTitle = new TextInput();
        _inputTitle.prompt = "Title";
        _addLayout.addChild(_inputTitle);

        _inputPrice = new TextInput();
        _inputPrice.prompt = "Price";
        _inputPrice.restrict = "0-9^.";
        _addLayout.addChild(_inputPrice);

        _submitBtn = new Button();
        _submitBtn.label = "Save";
        _addLayout.addChild(_submitBtn);

        _submitBtn.addEventListener(Event.TRIGGERED, buttonHandler);
    }

    private function buttonHandler(event:Event):void {
        var error:Boolean = false;
        var moderator:PersonVO = _personModel.getModerator();
        if (_inputTitle.text.length == 0) {
            var alert:Alert = Alert.show("Please fill in a title", "Error", new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }
        if (_inputPrice.text.length == 0) {
            var alert:Alert = Alert.show("Please fill in a price", "Error", new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }
        if (!error) {
            var obj:Object = {};
            var radio:Radio = _group.selectedItem as Radio;
            obj.title = _inputTitle.text;
            obj.price = _inputPrice.text;
            obj.type = String(radio.label).toLowerCase();

            _taskModel.add(obj);
            TaskService.write(_taskModel.tasks);

            _taskModel.currentTask = _taskModel.tasks[_taskModel.tasks.length - 1];
            _appModel.currentScreen = "detail";
        }
    }
}
}
