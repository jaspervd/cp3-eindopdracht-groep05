package be.devine.cp3.starling.billsplit.view.popups {

import be.devine.cp3.starling.billsplit.format.PriceFormat;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.display.Quad;
import starling.events.Event;


public class EditPerson extends ScrollContainer {
    private var _personModel:PersonModel;
    private var _taskModel:TaskModel;
    private var _popupLayout:LayoutGroup;
    private var _nameInput:TextInput;
    private var _priceInput:TextInput;
    private var _currentPerson:PersonVO;
    private var _container:Quad;

    public function EditPerson() {
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        _container = new Quad(400, 500, 0x5b7f73);
        this.backgroundSkin = _container;

        _personModel = PersonModel.getInstance();
        _taskModel = TaskModel.getInstance();

        _popupLayout = new LayoutGroup();
        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 5;
        layout.paddingTop = layout.paddingBottom = 10;
        _popupLayout.layout = layout;
        addChild(_popupLayout);

        _nameInput = new TextInput();
        _nameInput.prompt = "Name";
        _popupLayout.addChild(_nameInput);

        _priceInput = new TextInput();
        if(_taskModel.currency) {
            _priceInput.prompt = "Price";
            _priceInput.restrict = "0-9.,";
        } else {
            _priceInput.prompt = "Percentage";
            _priceInput.maxChars = 2;
            _priceInput.restrict = "0-9";
        }
        _popupLayout.addChild(_priceInput);

        var buttonLayout:LayoutGroup = new LayoutGroup();
        buttonLayout.layout = new HorizontalLayout();
        _popupLayout.addChild(buttonLayout);

        var saveButton:Button = new Button();
        saveButton.label = "Save";
        saveButton.addEventListener(Event.TRIGGERED, saveButtonHandler);
        buttonLayout.addChild(saveButton);

        var deleteButton:Button = new Button();
        deleteButton.label = "Delete";
        deleteButton.addEventListener(Event.TRIGGERED, deleteButtonHandler);
        buttonLayout.addChild(deleteButton);

        if (_personModel.currentPerson == null) {
            _personModel.addEventListener(PersonModel.CURRENT_PERSON_SET, currentPersonSetHandler);
        } else {
            currentPersonSetHandler();
        }
    }

    private function addedToStageHandler(event:Event):void {
        _container.width = stage.stageWidth * .85;
        _container.height = stage.stageHeight * .3;
        _popupLayout.x = (_container.width - _popupLayout.width) / 4;
        _popupLayout.y = (_container.height - _popupLayout.height) / 4;
    }

    private function currentPersonSetHandler(event:Event = null):void {
        _currentPerson = _personModel.currentPerson;
        _nameInput.text = _currentPerson.name;
        if(_taskModel.currency) {
            _priceInput.text = String(_currentPerson.iou);
        } else {
            _priceInput.text = String(_currentPerson.percentage);
        }
    }

    private function deleteButtonHandler(event:Event):void {
        _personModel.deleteById(_currentPerson.id);
        dispatchEvent(new Event(Event.CLOSE));
    }

    private function saveButtonHandler(event:Event):void {
        var error:Boolean = false;
        var moderator:PersonVO = _personModel.getModerator();

        var alert:Alert;

        var typeCurrency:String;
        if(_taskModel.currency) {
            typeCurrency = "price";
        } else {
            typeCurrency = "percentage";
        }

        if (_nameInput.text.length == 0 && _priceInput.text.length == 0) {
            alert = Alert.show("Please fill in all textboxes", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (_nameInput.text.length == 0) {
            alert = Alert.show("Please fill in a name", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (_priceInput.text.length == 0) {
            alert = Alert.show("Please fill in a " + typeCurrency, moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (isNaN(_priceInput.text as Number)) {
            alert = Alert.show("Please fill in a valid " + typeCurrency, moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }

        if (!error) {
            var personObj:Object = {};
            personObj.name = _nameInput.text;
            if(_taskModel.currency) {
                personObj.iou = _priceInput.text.split(',').join('.');
                personObj.percentage = PriceFormat.priceToPercentage(personObj.iou, _taskModel.currentTask.price);
            } else {
                personObj.iou = PriceFormat.percentageToPrice(Number(_priceInput.text), _taskModel.currentTask.price);
                personObj.percentage = _priceInput.text;
            }
            _personModel.updatePerson(_currentPerson, personObj);
            PersonService.write(_personModel.persons);

            _nameInput.text = _priceInput.text = "";
            dispatchEvent(new Event(Event.CLOSE));
        }
    }
}
}
