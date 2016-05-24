/**
 * Created by JiangHaiYang on 2016/5/23.
 */
package {
    import flash.display.DisplayObjectContainer;

    public class Child {
        public function Child() {
        }

        public static function removeChild(child:DisplayObjectContainer):void
        {
            if(child.parent)
            {
                child.parent.removeChild(child);
            }
        }

        public static function addChild(father:DisplayObjectContainer,child:DisplayObjectContainer,x:int = -1,y:int = -1)
        {
            if(x == -1)
            {
                x = (father.width + child.width) *0.5;
            }
            if(y == -1)
            {
                y = (father.height + child.height) *0.5;
            }
            child.x = x;
            child.y = y;
            father.addChild(child)
        }
    }
}
