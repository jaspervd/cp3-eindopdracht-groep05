package feathers.renderers {


import be.devine.cp3.starling.billsplit.vo.PersonVO;
import feathers.controls.Button;
import feathers.controls.renderers.DefaultListItemRenderer;
import starling.display.Image;
import starling.events.Event;


public class PersonListRenderer extends DefaultListItemRenderer {
    [Embed(source="/../assets/images/list-accessory-edit-icon.png")]
    public static const EditIcon:Class;


    [Embed(source="/../assets/images/price-icon.png")]
    public static const ListAccessory:Class;


    public static const EDIT_POPUP:String = "EDIT_POPUP";

    public function PersonListRenderer() {
        super();
        this.itemHasIcon = true;
        this.itemHasAccessory = true;
        this.accessoryPosition = "right";
    }

    protected var editButton:Button;

    override protected function commitData():void {
        super.commitData();
        const personVo:PersonVO = this._data as PersonVO;
        if (!personVo) {
            return;
        }

        var icon:Button = new Button();
        icon.label = personVo.iou as String;
        icon.defaultIcon = Image.fromBitmap(new ListAccessory());
        this.replaceIcon(icon);

        this.editButton = new Button();
        this.editButton.defaultIcon = Image.fromBitmap(new EditIcon());
        this.editButton.setSize(10, 10);
        this.editButton.addEventListener(Event.TRIGGERED, editButtonHandler);
        this.replaceAccessory(editButton);
    }

    private function editButtonHandler(event:Event):void {
        dispatchEvent(new Event(Event.CHANGE));
    }
}
}