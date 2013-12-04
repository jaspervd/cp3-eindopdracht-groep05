/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 26/09/13
 * Time: 14:13
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.queue {

import flash.events.Event;
import flash.events.EventDispatcher;

public class Queue extends EventDispatcher {
    private var _queue:Array;
    public var loadedItems:Array;

    public function Queue() {
        _queue = [];
        loadedItems = [];
    }

    public function add(item:ICanBeQueued):void {
        _queue.push(item);
    }

    public function start():void {
        if (_queue.length > 0) {
            var item:ICanBeQueued = _queue.shift();
            item.addEventListener(Event.COMPLETE, completeHandler);
            item.start();
        } else {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function completeHandler(event:Event):void {
        loadedItems.push(event.currentTarget);
        start();
    }
}
}
