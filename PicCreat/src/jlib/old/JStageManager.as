package jlib.old
{

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;


public class JStageManager
{
	
	private static var _instance:JStageManager;
	
	public static function get instance():JStageManager
	{
		if(_instance == null)
		{
			_instance = new JStageManager(new instanceClass());
		}
		
		return _instance;
	}
	public function JStageManager(insClass:instanceClass)
	{
	}
	
	
	public function get stage():Stage
	{
		return _stage;
	}
	
	public function get DisplayLayer():Sprite
	{
		return displayLayer;
	}
	private var _stage:Stage
	
	private var bgLayer:Sprite;
	
	private var displayLayer:Sprite;
	
	private var maskLayer:Sprite;
	public function setStage(stage:Stage):void
	{
		_stage = stage;
		bgLayer = new Sprite();
		
		displayLayer = new Sprite();
		maskLayer = new Sprite();
		_stage.addChild(bgLayer);
		_stage.addChild(displayLayer);
		_stage.addChild(maskLayer);
		
		_stage.addChild(new Stats());
		
	}
	
	public function addToBG(dim:DisplayObject):void
	{
		bgLayer.addChild(dim);
	}
	
	public function addToDisplay(dim:DisplayObject):void
	{
		displayLayer.addChild(dim);
	}
	
	public function addToMask(dim:DisplayObject):void
	{
		maskLayer.addChild(dim);
	}
	
	
	public function removeToDisplay(dim:DisplayObject):void
	{
		displayLayer.removeChild(dim);
	}
	
	public function removeToBG(dim:DisplayObject):void
	{
		bgLayer.removeChild(dim);
	}
	
	public function removeToMask(dim:DisplayObject):void
	{
		maskLayer.removeChild(dim);
	}
	
	
	public function addMask():void
	{
		
	}
	
	public function removeMask():void
	{
		
	}
	
	public function stageMode_TopLeft_Exactfit():void
	{
		_stage.align		=	StageAlign.TOP_LEFT;
		_stage.scaleMode	=	StageScaleMode.EXACT_FIT;
	}
	
	
	
	
	
}
}


class instanceClass{}