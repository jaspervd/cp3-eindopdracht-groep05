/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 15/12/13
 * Time: 17:52
 * To change this template use File | Settings | File Templates.
 */
package feathers.renderers {
import feathers.controls.Label;
import feathers.controls.renderers.LayoutGroupListItemRenderer;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

public class customListRenderer extends LayoutGroupListItemRenderer {
    public function customListRenderer() {
    }

    protected var _label:Label;

    protected var _padding:Number = 0;

    public function get padding():Number {
        return this._padding;
    }

    public function set padding(value:Number):void {
        if (this._padding == value) {
            return;
        }
        this._padding = value;
        this.invalidate(INVALIDATION_FLAG_LAYOUT);
    }

    override protected function initialize():void {
        this.layout = new AnchorLayout();

        var labelLayoutData:AnchorLayoutData = new AnchorLayoutData();
        labelLayoutData.top = 0;
        labelLayoutData.right = 0;
        labelLayoutData.bottom = 0;
        labelLayoutData.left = 0;

        this._label = new Label();
        this._label.layoutData = labelLayoutData;
        this.addChild(this._label);
    }

    override protected function commitData():void {
        if (this._data && this._owner) {
            this._label.text = this._data.title;
        }
        else {
            this._label.text = null;
        }
    }

    override protected function preLayout():void {
        var labelLayoutData:AnchorLayoutData = AnchorLayoutData(this._label.layoutData);
        labelLayoutData.top = this._padding;
        labelLayoutData.right = this._padding;
        labelLayoutData.bottom = this._padding;
        labelLayoutData.left = this._padding;
    }
}
}