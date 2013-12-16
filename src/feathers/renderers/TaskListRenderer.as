/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 15/12/13
 * Time: 17:52
 * To change this template use File | Settings | File Templates.
 */
package feathers.renderers {


import be.devine.cp3.starling.billsplit.format.DateFormat;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.vo.TaskVO;
import feathers.controls.Button;
import feathers.controls.renderers.DefaultListItemRenderer;
import starling.display.Image;
import starling.events.Event;



public class TaskListRenderer extends DefaultListItemRenderer {
    [Embed(source="/../assets/images/metalworks/list-accessory-drill-down-icon.png")]
    public static const ListAccessory:Class;

    public function TaskListRenderer() {
        super();
        this.itemHasIcon = true;
        this.itemHasAccessory = true;
        this.accessoryPosition = "left";
    }

    protected var goToButton:Button;

    override protected function commitData():void {
        super.commitData();
        const task:TaskVO = this._data as TaskVO;
        if (!task) {
            return;
        }

        trace(DateFormat.timestampToUFDate(task.timestamp));

        var icon:Button = new Button();
        icon.defaultIcon = TaskService.icon(task);
        this.replaceIcon(icon);

        this.goToButton = new Button();
        this.goToButton.defaultIcon = Image.fromBitmap(new ListAccessory());
        this.goToButton.setSize(10, 10);
        this.goToButton.addEventListener(Event.TRIGGERED, goToButtonHandler);
        this.replaceAccessory(goToButton);
    }

    private function goToButtonHandler(event:Event):void {
        dispatchEvent(new Event(Event.TRIGGERED));
    }
}
}