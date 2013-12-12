package be.devine.cp3.starling.billsplit.service {

import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.IListItemRenderer;

import flash.display3D.textures.Texture;

import starling.display.Image;

import starling.textures.Texture;

public class Skins {


    [Embed(source="/../assets/images/metalworks/transparent_repeat.png")]
    public static const Transparent:Class;

    public function Skins() {



    }

    public static function TaskListItem(genre:String):IListItemRenderer{

        //var texture:flash.display3D.textures.Texture = ;

        var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
       // renderer.defaultSkin = new Image(  );
        return renderer;

    }
}
}
