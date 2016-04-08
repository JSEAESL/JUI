/**
 * Created by JiangHaiYang on 2015/12/24.
 */
package BaseRes {
    public class JBaseLoadingInfo {
        //完成回调
        private var _nextFun:Function;
        private var _nextArg:Array;

        //进度主动查询函数
        private var _progressChangeFun:Function;
        private var _progressChangeArg:Array;

        //加载个数
        private var _totalCount:uint = 0;
        private var _nowCount:uint = 0;

        private var _autoDelay:Number = 0;

        public function get autoDelay():Number
        {
            return _autoDelay;
        }
        public function get nextFun():Function
        {
            return _nextFun;
        }

        public function get progressChangeFun():Function
        {
            return _progressChangeFun;
        }

        public function get totalCount():uint
        {
            return _totalCount;
        }

        public function get nowCount():uint
        {
            return _nowCount;
        }

        public function JBaseLoadingInfo()
        {

        }

        public static function creatInfo(nextFun:Function,nextArg:Array = null):JBaseLoadingInfo
        {
            var result:JBaseLoadingInfo = new JBaseLoadingInfo();
            result._nextFun = nextFun;
            result._nextArg= nextArg;
            return result;
        }

        public function addTotlInfo(totalCount:uint,nowCount:uint):void
        {
            this._totalCount = totalCount;
            this._nowCount = nowCount;
        }

        public function add_progressFun(progressChangeFun:Function,progressChangeArg:Array = null):void
        {
            this._progressChangeFun = progressChangeFun;
            this._progressChangeArg = progressChangeArg;
        }

        public function setAutoDelay(autoDelay:Number):void
        {
            this._autoDelay = autoDelay
        }
    }
}
