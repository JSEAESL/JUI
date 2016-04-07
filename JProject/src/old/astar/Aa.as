package old.astar
{
	

	public class Aa
	{
		private var _open:Array;//待查数组
		private var _closed:Array;//已查数组
		private var _grid:Grid;
		private var _endNode:Node;
		private var _startNode:Node;
		private var _path:Array;
		private var _heuristic:Function = diagonal; //启发函数
		//		private var _heuristic:Function = euclidian;
		//		private var _heuristic:Function = diagonal;
		private var _straightCost:Number = 1.0; //垂直，水平直线代价
		private var _diagCost:Number = Math.SQRT2;//对角线代价		
		
		private var _matrix:Array = [
			 [0,-1],[-1,-1],[-2,0]
			,[1,-1],[-1,0]
			,[2,0],[1,0],[0,1]
		];
		
		public function Aa()
		{
		}
		
		public function NewSearch():void
		{
			_open = [];
			_closed = [];
			
			_startNode = null;
			_endNode = null
			
			_path = [];
		}
		
		
		public function findPath(grid:Grid):Boolean
		{
			_grid = grid;
			_open = new Array();
			_closed = new Array();

			_startNode = _grid.startNode;
			_endNode = _grid.endNode;

			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;

			return search();
		}

		public function _search():Boolean
		{
			var node:Node = _startNode;
			while(node != _endNode)
			{
				var idx:int = 0;
				for each(var n:Array in _matrix)
				{
					var test:Node;
					if (node.x % 2 != 0 
						&& (idx == 1 || idx == 3 || idx == 4 || idx == 6)){
						test = _grid.getNode(node.x + n[0] , node.y + n[1] + 1);
					}
					else{
						test = _grid.getNode(node.x + n[0] , node.y + n[1]);
					}
					if(!test.walkable)
					{
						continue;
					}

					var cost:Number = _straightCost;

					//! 判断是否为直线
					if (!((node.x == test.x + 1 || node.x == test.x - 1)
						&&(node.y == test.y || node.y == test.y + 1)))
					{
						cost = _diagCost;
					}

					var g:Number = node.g + cost; //! 换算到像素
					var h:Number = _heuristic(test);
					var f:Number = g + h;

					if(isOpen(test) || isClosed(test))
					{
						if(test.f > f)
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
						}
					}
					else
					{
						test.f = f;
						test.g = g;
						test.h = h;
						test.parent = node;
						_open.push(test);
					}
					idx++;
				}

				_closed.push(node);
				if(_open.length == 0)
				{
					trace("no path found");
					return false;
				}
	
				_open.sortOn("f", Array.NUMERIC);
				node = _open.shift() as Node;
				trace ("path x:" + node.x + "y:" + node.y);
			}
			buildPath();
			return true;
		}

		public function search():Boolean
		{
			var node:Node = _startNode;
			while(node != _endNode)
			{
				var startX:int = Math.max(0, node.x - 1);
				var endX:int = Math.min(_grid.numCols - 1, node.x + 1);

				var startY:int = Math.max(0, node.y - 1);
				var endY:int = Math.min(_grid.numRows - 1, node.y + 1);

				for(var i:int = startX; i <= endX; i++)
				{
					for(var j:int = startY; j <= endY; j++)
					{
						var test:Node = _grid.getNode(i, j);
						if(test == node || 
							!test.walkable ||
							!_grid.getNode(node.x, test.y).walkable ||
							!_grid.getNode(test.x, node.y).walkable)
						{
							continue;
						}

						var cost:Number = _straightCost;
						if(!((node.x == test.x) || (node.y == test.y))){
							cost = _diagCost;
						}
						var g:Number = node.g + cost * test.costMultiplier;
						var h:Number = _heuristic(test);
						var f:Number = g + h;
						if(isOpen(test) || isClosed(test))
						{
							if(test.f > f)
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
							}
						}
						else
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							_open.push(test);
						}
					}
				}

				_closed.push(node);
				if(_open.length == 0)
				{
					trace("no path found");
					return false
				}
				_open.sortOn("f", Array.NUMERIC);
				node = _open.shift() as Node;
				trace(node.x,node.y,node.f)
			}
			buildPath();
			return true;
		}

		private function buildPath():void
		{
			_path = new Array();
			var node:Node = _endNode;
			_path.push(node);
			while(node != _startNode)
			{
				node = node.parent;
				_path.unshift(node);
			}
		}
		
		public function get path():Array
		{
			return _path;
		}
		
		private function isOpen(node:Node):Boolean
		{
			for(var i:int = 0; i < _open.length; i++)
			{
				if(_open[i] == node)
				{
					return true;
				}
			}
			return false;
		}
		
		private function isClosed(node:Node):Boolean
		{
			for(var i:int = 0; i < _closed.length; i++)
			{
				if(_closed[i] == node)
				{
					return true;
				}
			}
			return false;
		}
	

		private function manhattan(node:Node):Number
		{
			return Math.abs(node.x - _endNode.x) * _straightCost 
				+ Math.abs(node.y + _endNode.y) * _straightCost;
		}

		private function euclidian(node:Node):Number
		{
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}
		
		/*private function _euclidian(node:Node):Number
		{
			var pos:Point = KMapUtils.getPixelPoint(new Point(node.y , node.x));
			var endPos:Point = KMapUtils.getPixelPoint(new Point(_endNode.y , _endNode.x));

			var dx:Number = pos.x - endPos.x;
			var dy:Number = pos.y - endPos.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}*/
		
		private function diagonal(node:Node):Number
		{
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
		public function get visited():Array
		{
			return _closed.concat(_open);
		}
	}
}