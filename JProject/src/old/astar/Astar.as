package old.astar
{
	

	public class Astar
	{
		
		private var DIAG_COST:Number = Math.SQRT2;
		private var STRAIGHT_COST:Number = 1.0;
		
		
		private var grid:Grid;		
		
		private var openList:Array;
		private var closeList:Array;
		
		private var starNode:Node;
		private var endNode:Node;
		
		private var _path:Array;
		
		
		private var _heuristic:Function = diagonal;
		public function Astar()
		{
			openList = [];
			closeList = [];
		}
		
		
		public function get path():Array
		{
			return _path;
		}
		
		public function cleanPath():void
		{
			_path = [];
		}

		public function findPath(dim:Grid):Boolean
		{
			grid = dim;
			
			starNode = grid.startNode;
			endNode = grid.endNode;
			
			
			starNode.g = 0;
			starNode.h = _heuristic(starNode);
			starNode.f = starNode.g + starNode.h;
			
			return search();
		}
		
		private function search():Boolean
		{
			var node:Node = starNode;
			
			while(node != endNode)
			{
				var startX:int = Math.max(0,node.x - 1)
				var startY:int = Math.max(0,node.y - 1)
					
				var endX:int = Math.min(grid.numCols - 1,node.x + 1);
				var endY:int = Math.min(grid.numRows - 1,node.y + 1);
				
				for(var x:int = startX; x <=endX; x++)
				{
					for(var y:int = startY; y<=endY; y++)
					{
						var test:Node = grid.getNode(x,y);
						
						if(
							test == node ||
							!test.walkable ||
							!grid.getNode(node.x,test.y).walkable ||
							!grid.getNode(test.x,node.y).walkable  )
						{
							continue;
						}
						
						var cost:Number = STRAIGHT_COST;
						if( !((node.x == test.x) || (node.y == test.y)))
						{
							cost = DIAG_COST;
						}
						
						
						var g:Number = node.g + cost * test.costMultiplier;
						var h:Number = _heuristic(test);
 						var f:Number = g + h; 
						
						if( isClose(test) || isOpen(test) )
						{
							if(test.f > f)
							{
								test.g = g;
								test.h = h;
								test.f = f;
								test.parent = node;
							}
						}else
						{
							test.g = g;
							test.h = h;
							test.f = f;
							test.parent = node;
							openList.push(test);
						}
					}
				}
				
				closeList.push(node);
				
				if(openList.length == 0)
				{
					return false;
				}
				
				openList.sortOn("f", Array.NUMERIC);
				node = openList.shift() as Node;
				//trace(node.x,node.y,node.f)
			}
			buildPath();
			return true;
		}
		
	/*	private function order(pre:Node, next:Node):Number
		{
			var preValue:int=pre.f;
			var nextValue:int=next.f;
			
			if (preValue < nextValue)
			{
				return -1;
			}
			else if (preValue > nextValue)
			{
				return 1;
			}
			else
			{
				return 0;
				
			}
		}*/
		
		public function NewSearch():void
		{
			 openList = [];
			closeList = [];
			
			starNode = null;
			endNode = null
			
			 _path = [];
		}
		
	
		private function buildPath():void
		{
			_path = new Array();
			var t:Node = endNode;
			if(t == null)
			{
				trace("stop");
			}
			_path.push(t);
			while(t != starNode)
			{
				t = t.parent;
				_path.unshift(t);
			}
		}
		
		
		private function isClose(dim:Node):Boolean
		{
			for each (var i:Node in closeList)
			{
				if(i == dim)
				{
					return true;
				}
			}
			return false;
		}
		
		private function isOpen(dim:Node):Boolean
		{
			for each (var i:Node in openList)
			{
				if(i == dim)
				{
					return true;
				}
			}
			
			return false;
		}
		
		
		private function diagonal(nowNode:Node):Number
		{
			var dx:Number = Math.abs(nowNode.x - endNode.x);
			var dy:Number = Math.abs(nowNode.y - endNode.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return DIAG_COST * diag + STRAIGHT_COST * (straight - 2 * diag);
		}
		
		private function manhattan(node:Node):Number
		{
			return Math.abs(node.x - endNode.x) * STRAIGHT_COST 
				+ Math.abs(node.y + endNode.y) * STRAIGHT_COST;
		}
		
		private function euclidian(node:Node):Number
		{
			var dx:Number = node.x - endNode.x;
			var dy:Number = node.y - endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * STRAIGHT_COST;
		}
		
		/*private function _euclidian(node:Node):Number
		{
			var pos:Point = KMapUtils.getPixelPoint(new Point(node.y , node.x));
			var endPos:Point = KMapUtils.getPixelPoint(new Point(_endNode.y , _endNode.x));
			
			var dx:Number = pos.x - endPos.x;
			var dy:Number = pos.y - endPos.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}*/
		
	}
}