/**
 * Created with IntelliJ IDEA.
 * User: test
 * Date: 9/12/13
 * Time: 13:41
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import feathers.controls.LayoutGroup;

import feathers.controls.Screen;
import feathers.layout.VerticalLayout;

import starling.display.Image;
import starling.text.TextField;

public class Overview extends Screen {
    private var _personModel:PersonModel;
    private var _moderator:PersonVO;
    private var _profile:Image;
    private var _fullName:TextField;
    private var _profileLayout:LayoutGroup;

    public function Overview() {

        _personModel = PersonModel.getInstance();

        _moderator = _personModel.getModerator();


        _profileLayout = new LayoutGroup();
        _profileLayout.layout = new VerticalLayout();
        addChild(_profileLayout);


        _fullName = new TextField(actualWidth,actualHeight,_moderator.name,null,28,0xffffff);


    }



    override protected function initialize():void{

        _profileLayout.addChild(_fullName);

        trace('[OVERVIEW]');
    }


    override protected function draw():void{

        _profileLayout.width = stage.stageWidth;

    }
}
}
