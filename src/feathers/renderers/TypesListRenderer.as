/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 15/12/13
 * Time: 17:52
 * To change this template use File | Settings | File Templates.
 */
package feathers.renderers {


import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.vo.TaskVO;
import feathers.controls.Button;
import feathers.controls.renderers.DefaultListItemRenderer;

import starling.events.Event;

public class TypesListRenderer extends DefaultListItemRenderer {
    public function TypesListRenderer() {
        super();
        this.itemHasIcon = true;
        this.itemHasLabel = false;
    }

    override protected function commitData():void {
        super.commitData();
        const task:TaskVO = TaskVOFactory.createTaskVOFromObject(this._data) as TaskVO;
        if (!task) {
            return;
        }

        this.labelField = this._data.type;

        var icon:Button = new Button();
        icon.defaultIcon = TaskService.icon(task);
        icon.addEventListener(Event.TRIGGERED, triggeredHandler);

        if(this.isSelected){

            icon.setSize(70,70)

        }else{

            icon.setSize(100,100);

        }

        this.replaceIcon(icon);
    }

    private function triggeredHandler(event:Event):void {
        dispatchEvent(new Event(Event.TRIGGERED));
    }
}
}