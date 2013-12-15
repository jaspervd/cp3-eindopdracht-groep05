/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 15/12/13
 * Time: 17:52
 * To change this template use File | Settings | File Templates.
 */
package feathers.renderers {
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import feathers.controls.Button;
import feathers.controls.renderers.DefaultListItemRenderer;

import flash.display.Bitmap;

import starling.display.Image;
import starling.events.Event;

public class TaskListRenderer extends DefaultListItemRenderer {
    [Embed(source="/../assets/images/metalworks/list-accessory-drill-down-icon.png")]
    public static const ListAccessory:Class;

    [Embed(source="/../assets/images/metalworks/bar.png")]
    public static const BarIcon:Class;

    [Embed(source="/../assets/images/metalworks/restaurant.png")]
    public static const ResIcon:Class;

    [Embed(source="/../assets/images/metalworks/cinema.png")]
    public static const CinemaIcon:Class;

    [Embed(source="/../assets/images/metalworks/overige.png")]
    public static const OtherIcon:Class;

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

        var icon:Button = new Button();
        switch(task.type) {
            case 'restaurant':
                icon.defaultIcon = Image.fromBitmap(new ResIcon());
                break;
            case 'cinema':
                icon.defaultIcon = Image.fromBitmap(new CinemaIcon());
                break;
            case 'bar':
                icon.defaultIcon = Image.fromBitmap(new BarIcon());
                break;
            default:
                icon.defaultIcon = Image.fromBitmap(new OtherIcon());
                break;
        }
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