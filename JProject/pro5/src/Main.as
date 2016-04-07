package {

import flash.display.Sprite;
import flash.text.TextField;

public class Main extends Sprite {
    private var　textField:TextField;
    public function Main() {
        textField　= new TextField();
        textField.text = "Hello, World";
        addChild(textField);
        textField.text  = creatAns();
    }

    private function creatAns():String
    {
        var mustArr:Array = [];
        var needArr:Array = [];
        var total:Number = 1;

        var isSave:Boolean = false;
        for(var i:int = 2;i<=10;i++)
        {
            isSave = false;
            var index:int = 0;
            for( var j:int =2; j<i;j++)
            {
                if(isSave)
                {
                    break;
                }
                if( i%j == 0  )
                {
                    var mustLen:int = mustArr.length;
                    for(var t:int = 0;t<mustLen;t++)
                    {
                        if(mustArr[t] * mustArr[t] ==i )
                        {
                            mustArr.push(mustArr[t]);
                            total = total*mustArr[t];
                            isSave = true;
                            break;
                        }
                    }
                }
            }
            if(!isSave)
            {
                mustArr.push(i);
                total = total*i;
            }
        }

            return total + "";
    }
}
}
