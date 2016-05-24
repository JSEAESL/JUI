package jlib.unit.astar.test
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import jlib.astar.Aa;
	import jlib.astar.Astar;
	import jlib.astar.Grid;
	import jlib.astar.Node;
	import jlib.ui.JAButton;
	import jlib.ui.JButtonDeco;
	import jlib.ui.JMapBox;

	public class AtestBox extends Sprite
	{
		
		private var box:JMapBox;
		//private var A:Aa;
		private var A:Astar;
		public function AtestBox()
		{
			//A = new Aa();
			A = new Astar();
			box = new JMapBox(600,600,0xffffff);
			addChild(box);
			
			buildGrid();
			
			buildMap();
			time.addEventListener(TimerEvent.TIMER,onTimer);
			
			box.addElementBtn(new JButtonDeco("走",new JAButton(go)))
		}
		
		private function go():void
		{
			if(start && end)
			{
				A.NewSearch();
				A.findPath(grid)
				drawPath();
			}
			
		}
		
		private var map:Sprite;
		//private var black:Sprite;
		private function buildMap():void
		{
			map = new Sprite();
			//black = new Sprite
			map.graphics.lineStyle(1);
			map.addEventListener(MouseEvent.CLICK,onClick);
			map.graphics.beginFill(0xffffff);
			map.graphics.drawRect(0,0,500,500);
			for(var x:int = 0; x<=500; x = x + 25)
			{
				for(var y:int = 0; y<=500; y = y +25)
				{
					
					
					map.graphics.moveTo(0,y);
					map.graphics.lineTo(500,y);
				}
				map.graphics.moveTo(x,0);
				map.graphics.lineTo(x,500);
			}
			box.addLine(map);	
			
			
			for(var x:int = 0; x<20; x++)
			{
				for(var y:int = 0; y<20; y++)
				{
					var sp:Sprite = new Sprite();
					var node:Node = grid.getNode(x,y);
					if(node.walkable == false)
					{
						sp.graphics.beginFill(0x000000);
						sp.graphics.drawRect(x*25,y*25,25,25);
						sp.graphics.endFill();
					}
					map.addChild(sp);
				}
			}
			
			map.addChild(pathSp);
			map.addChild(startSp);
			map.addChild(endSp);
		}
		
		private var startSp:Sprite = new Sprite();
		private var endSp:Sprite = new Sprite();
		
		private var start:Boolean = false;
		private var end:Boolean = false;
		private function onClick(e:MouseEvent):void
		{
			var x:int = Math.floor(e.localX/25);
			var y:int = Math.floor(e.localY/25);
			
			
			startSp.graphics.beginFill(0xff00ff,0.5);
			endSp.graphics.beginFill(0x00ff00,0.5);
			
			var clickNode:Node = grid.getNode(x,y);
			if(!start  && clickNode.walkable == true)
			{
				
				grid.setStartNode(x,y);
				startSp.graphics.drawRect(x*25,y*25,25,25);
				start = true;
			}else if(!end  && clickNode.walkable == true )
			{
				
				grid.setEndNode(x,y);
				endSp.graphics.drawRect(x*25,y*25,25,25);
				end = true;
			}
			else
			{
				startSp.graphics.clear();
				endSp.graphics.clear();
				pathSp.graphics.clear();
				//A.cleanPath();
				start = false;
				end = false;
			}
			
		}
		
		private var time:Timer = new Timer(50)
		private function drawPath():void
		{
			if(A.path)
			{
				
				pathSp.graphics.lineStyle(2);
		
				pathSp.graphics.moveTo(grid.startNode.x * 25 + 12,grid.startNode.y * 25 + 12);
				time.start();
			}
		}
		
		
		private var pathSp:Sprite = new Sprite();
		private function onTimer(e:TimerEvent):void
		{
			if(A.path.length>0)
			{
				var t:Node = A.path.shift();
				pathSp.graphics.lineTo(t.x * 25 + 12,t.y * 25 + 12);
		
			}
			else
			{
				time.stop();
			}
			
		}
		
		private var grid:Grid;
		private function buildGrid():void
		{
			grid  = new Grid(20,20);
			
			var num:int = -50;
			
			
			while(num<0)
			{
				var ix:int = Math.floor(Math.random()*20);
				var iy:int = Math.floor(Math.random()*20);	
				
				if(grid.getNode(ix,iy).walkable == true)
				{
					grid.getNode(ix,iy).walkable = false;
					num++;
				}
			}
			
			trace(grid);		
					
			
		}
	}
}