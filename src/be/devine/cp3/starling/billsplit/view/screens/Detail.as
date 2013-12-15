/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 12/12/13
 * Time: 15:14
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.Application;
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import feathers.controls.LayoutGroup;

import feathers.controls.List;

import feathers.controls.Screen;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import flash.events.Event;

import starling.text.TextField;

public class Detail extends Screen {
    private var _appModel:AppModel;
    private var _taskModel:TaskModel;
    private var _personModel:PersonModel;
    private var _personList:List;
    private var _taskLayout:LayoutGroup;
    private var _taskTitle:TextField;
    private var _currentTask:TaskVO;
    
    public function Detail() {
        _appModel = AppModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _personModel = PersonModel.getInstance();
        _currentTask = new TaskVO();

        _appModel.addEventListener(Event.CHANGE, updateTask);

        _personList = new List();
        _personList.itemRendererProperties.labelField = "name";
        addChild(_personList);

        _taskLayout = new LayoutGroup();
        addChild(_taskLayout);

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 15;
        layout.paddingTop = 100;
        _taskLayout.layout = layout;

        _taskTitle = new TextField(100, 30, "", "SourceSansProSemiBold", 28, 0xFFFFFF);
        _taskLayout.addChild(_taskTitle);
    }

    private function updateTask(event:Event):void {
        if(_taskModel.currentTask) {
            _currentTask = _taskModel.currentTask;

            trace('Current Task:', _currentTask.title);
            _taskTitle.text = _currentTask.title;
            trace(_personModel.getPersonsByTaskId(_currentTask.id));
            trace(_currentTask.id);
            _personList.dataProvider = new ListCollection(_personModel.getPersonsByTaskId(_currentTask.id));
        }
    }

    override protected function initialize():void {
        layout();
        trace('[DETAIL]');
    }


    private function layout():void {
        _taskTitle.width = stage.stageWidth;

        _taskLayout.setSize(stage.stageWidth, 200);
        _personList.setSize(stage.stageWidth, (stage.stageHeight - _taskLayout.height));
        _personList.y = _taskLayout.height;
    }
}
}