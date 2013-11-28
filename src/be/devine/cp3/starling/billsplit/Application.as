/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 28/11/13
 * Time: 16:54
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit {
import be.devine.cp3.starling.billsplit.model.AppModel;

import starling.display.Sprite;

public class Application extends Sprite {
    private var _appModel:AppModel;

    public function Application() {
        _appModel = new AppModel();

        trace('Hello world');
    }
}
}
