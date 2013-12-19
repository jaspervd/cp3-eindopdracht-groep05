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
import starling.events.Event;



public class PersonListRenderer extends DefaultListItemRenderer {
    //[Embed(source="/../assets/images/metalworks/list-accessory-drill-down-icon.png")]
    //public static const ListAccessory:Class;

    public function PersonListRenderer() {
        super();
        this.itemHasIcon = false;
        this.itemHasAccessory = false;
        this.accessoryPosition = "right";
        this.labelField = "";
    }

    protected var editButton:Button;
    protected var deleteButton:Button;

    override protected function commitData():void {
        super.commitData();
        const person:PersonVO = this._data as PersonVO;
        if (!person) {
            return;
        }

        this.editButton = new Button();
        //this.goToButton.defaultIcon = Image.fromBitmap(new ListAccessory());
        this.editButton.label = "Edit";
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