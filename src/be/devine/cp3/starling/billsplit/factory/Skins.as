package be.devine.cp3.starling.billsplit.factory {

import feathers.controls.Button;
import feathers.skins.SmartDisplayObjectStateValueSelector;
import starling.textures.Texture;
import starling.textures.TextureAtlas;


public class Skins {

    [Embed(source="/../assets/images/splits.xml", mimeType="application/octet-stream")]
    public static const SplitsXML:Class;


    public function Skins() {

        trace("[THIS CLASS ADDS SKINS TO ANYTHING IN FEATHERS]");

    }

    public static function defaultSkin(newClass:Class):SmartDisplayObjectStateValueSelector{


        var defaultTexture:Texture = Texture.fromBitmap(new newClass());

        var defaultTexture:Texture = Texture.fromBitmap(new newClass());
        var xml:XML = XML(new SplitsXML());
        var atlas:TextureAtlas = new TextureAtlas(defaultTexture, xml);

// display a sub-texture
        var skin:Texture = atlas.getTexture("transparent");


        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = skin;
        skinSelector.defaultSelectedValue = skin;
        skinSelector.setValueForState( skin, Button.STATE_DOWN, false);
        skinSelector.setValueForState( skin, Button.STATE_HOVER, false);
        skinSelector.setValueForState( skin, Button.STATE_DISABLED, false);
        skinSelector.setValueForState( skin, Button.STATE_DOWN, true);
        skinSelector.setValueForState( skin, Button.STATE_HOVER, true);
        skinSelector.setValueForState( skin, Button.STATE_DISABLED,true);

        trace("NEW SKIN ASSIGNED");

        return skinSelector;

    }
}
}
