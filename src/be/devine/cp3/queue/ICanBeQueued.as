/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 26/09/13
 * Time: 15:36
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.queue {
import flash.events.IEventDispatcher;

public interface ICanBeQueued extends IEventDispatcher {
    function start():void;
}
}
