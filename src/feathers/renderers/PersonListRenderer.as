/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 15/12/13
 * Time: 17:52
 * To change this template use File | Settings | File Templates.
 */
package feathers.renderers {

import be.devine.cp3.starling.billsplit.vo.PersonVO;
import feathers.controls.Button;
import feathers.controls.renderers.DefaultListItemRenderer;

import starling.display.Image;
import starling.events.Event;



public class PersonListRenderer extends DefaultListItemRenderer {
    [Embed(source="/../assets/images/list-accessory-edit-icon.png")]
    public static const ListAccessory:Class;

    [Embed(source="/../assets/images/price-icon.png")]
    public static const PriceIcon:Class;

    public function PersonListRenderer() {
        super();
        this.itemHasIcon = true;
        this.itemHasAccessory = true;
    }

    protected var editButton:Button;
    protected var deleteButton:Button;

    override protected function commitData():void {
        super.commitData();
        const person:PersonVO = this._data as PersonVO;
        if (!person) {
            return;
        }

        var icon:Button = new Button();
        icon.label = person.iou as String;
        icon.labelOffsetX = -100;
        icon.defaultIcon = Image.fromBitmap(new PriceIcon());
        this.replaceIcon(icon);

        this.editButton = new Button();
        this.editButton.defaultIcon = Image.fromBitmap(new ListAccessory());
        this.editButton.setSize(10, 10);
        this.editButton.addEventListener(Event.TRIGGERED, editButtonHandler);
        this.replaceAccessory(editButton);
    }

    private function editButtonHandler(event:Event):void {
        this.deleteButton = new Button();
        this.deleteButton.label = "Delete";
        this.deleteButton.addEventListener(Event.TRIGGERED, deleteButtonHandler);
        this.replaceAccessory(deleteButton);
    }

    private function deleteButtonHandler(event:Event):void {
        trace('DELETE PERSON');
    }
}
}