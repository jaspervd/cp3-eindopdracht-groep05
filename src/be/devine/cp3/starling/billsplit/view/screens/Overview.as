/**
 * Created with IntelliJ IDEA.
 * User: test
 * Date: 9/12/13
 * Time: 13:41
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import feathers.controls.ImageLoader;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.Screen;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import flash.filesystem.File;

import starling.events.Event;
import starling.text.TextField;


public class Overview extends Screen {


    public var screenName:String = "Overview";



    private var _personModel:PersonModel;
    private var _taskModel:TaskModel;
    private var _moderator:PersonVO;
    private var _tasks:Array;
    private var _profile:ImageLoader;
    private var _fullName:TextField;
    private var _profileLayout:LayoutGroup;
    private var _taskList:List;

    public function Overview() {

        _personModel = PersonModel.getInstance();
        _taskModel = TaskModel.getInstance();

        _moderator = _personModel.getModerator();

        _tasks = _taskModel.getAllTasks();


        _profileLayout = new LayoutGroup();
        addChild(_profileLayout);

        _taskList = new List();
        _taskList.itemRendererProperties.labelField = "title";
        addChild(_taskList);




        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 15;
        layout.paddingTop = 100;
        _profileLayout.layout = layout;


        var image:File = File.applicationStorageDirectory.resolvePath(_moderator.image);
        _profile = new ImageLoader();
        _profile.source = image.url;
        _profile.addEventListener(Event.COMPLETE, imageCompleteHandler);
        _profileLayout.addChild(_profile);


        _fullName = new TextField(100, 30, _moderator.name, "SourceSansProSemiBold", 28, 0xFFFFFF);
        _profileLayout.addChild(_fullName);

    }

    private function imageCompleteHandler(event:Event):void {

        _profile.setSize(200,200);

    }


    override protected function initialize():void {
        layout();
        trace('[OVERVIEW]');
    }


    private function layout():void {
        _fullName.width = stage.stageWidth;

        _profileLayout.setSize(stage.stageWidth, 500);
        _profile.x = (stage.stageWidth + _profile.width) / 2;
        _taskList.setSize(stage.stageWidth, (stage.stageHeight - _profileLayout.height));
        _taskList.y = _profileLayout.height;
        _taskList.dataProvider = new ListCollection(_tasks);


    }
}
}
