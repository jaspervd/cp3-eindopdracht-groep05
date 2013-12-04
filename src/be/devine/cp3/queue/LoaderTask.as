/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 26/09/13
 * Time: 15:47
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.queue {
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

public class LoaderTask extends Loader implements ICanBeQueued {
    private var _url:String;

    public function LoaderTask(url:String) {
        this._url = url;
    }

    public function start():void {
        this.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
        this.load(new URLRequest(_url));
    }

    private function loaderCompleteHandler(event:Event):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}