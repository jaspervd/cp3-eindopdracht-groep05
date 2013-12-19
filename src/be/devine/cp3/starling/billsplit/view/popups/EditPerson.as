/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 19/12/13
 * Time: 16:02
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.popups {
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import feathers.controls.Alert;

import feathers.controls.Button;

import feathers.controls.LayoutGroup;

import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.events.Event;

public class EditPerson extends Screen {
    private var _personModel:PersonModel;
    private var _popupLayout:LayoutGroup;
    private var _nameInput:TextInput;
    private var _priceInput:TextInput;
    private var _buttonLayout:LayoutGroup;
    private var _saveButton:Button;
    private var _deleteButton:Button;
    private var _currentPerson:PersonVO;

    public function EditPerson() {
        _personModel = PersonModel.getInstance();

        _popupLayout = new LayoutGroup();
        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 15;
        layout.paddingTop = 100;
        _popupLayout.layout = layout;
        addChild(_popupLayout);

        _nameInput = new TextInput();
        _popupLayout.addChild(_nameInput);

        _priceInput = new TextInput();
        _popupLayout.addChild(_priceInput);

        _buttonLayout = new LayoutGroup();
        _buttonLayout.layout = new HorizontalLayout();
        _popupLayout.addChild(_buttonLayout);

        _saveButton = new Button();
        _saveButton.label = "Save";
        _saveButton.addEventListener(Event.TRIGGERED, saveButtonHandler);
        _buttonLayout.addChild(_saveButton);

        _deleteButton = new Button();
        _deleteButton.label = "Delete";
        _deleteButton.addEventListener(Event.TRIGGERED, deleteButtonHandler);
        _buttonLayout.addChild(_deleteButton);

        if(_personModel.currentPerson == null) {
            _personModel.addEventListener(PersonModel.CURRENT_PERSON_SET, currentPersonSetHandler);
            trace('currentperson is null');
        } else {
            trace('currentperson is ', _personModel.currentPerson.name);
            currentPersonSetHandler();
        }
    }

    private function currentPersonSetHandler(event:Event = null):void {
        _currentPerson = _personModel.currentPerson;
        _nameInput.text = _currentPerson.name;
        _priceInput.text = String(_currentPerson.iou);
    }

    private function deleteButtonHandler(event:Event):void {
        _personModel.deleteById(_currentPerson.id);
        dispatchEvent(new Event(Event.CLOSE));
    }

    private function saveButtonHandler(event:Event):void {
        var error:Boolean = false;
        var moderator:PersonVO = _personModel.getModerator();

        var alert:Alert;

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
            alert = Alert.show("Please fill in a title", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (isNaN(_priceInput.text as Number)) {
            alert = Alert.show("Please fill in a valid price", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }

        if (!error) {
            var personObj:Object = {};
            personObj.name = _nameInput.text;
            personObj.iou = _priceInput.text;
            _personModel.updatePerson(_currentPerson, personObj);
            PersonService.write(_personModel.persons);

            _nameInput.text = _priceInput.text = "";
            dispatchEvent(new Event(Event.CLOSE));
        }
    }
}
}
