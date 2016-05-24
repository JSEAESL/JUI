package {

import flash.display.Sprite;
import flash.text.TextField;

public class RubT extends Sprite {
    public function RubT() {
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);
        init();
    }
    private function init():void
    {
        var S:Stats = new Stats();
        //addChild(S);
    }
}
}
