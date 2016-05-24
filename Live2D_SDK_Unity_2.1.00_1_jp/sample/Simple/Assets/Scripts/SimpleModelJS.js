#pragma strict
import live2d;
import System;

public var mocFile:TextAsset ;
public var textureFiles:Texture2D[];
	
private var live2DModel:Live2DModelUnity;
private var live2DCanvasPos:Matrix4x4;


function Start () {
    Live2D.init();
    live2DModel = Live2DModelUnity.loadModel(mocFile.bytes);
    for (var i:int = 0; i < textureFiles.Length; i++)
    {
        live2DModel.setTexture(i, textureFiles[i]);
    }
		
    var modelWidth:float = live2DModel.getCanvasWidth();
    live2DCanvasPos = Matrix4x4.Ortho(0, modelWidth, modelWidth, 0, -50.0, 50.0);
}

function Update () {
    if (live2DModel == null) return;
    live2DModel.setMatrix(transform.localToWorldMatrix * live2DCanvasPos);

    if (!Application.isPlaying)
    {
        live2DModel.update();
        return;
    }
    
    var t:float = (UtSystem.getUserTimeMSec()/1000.0) * 2 * Math.PI  ;
    var value:float=(30 * Math.Sin( t/3.0 ));
    var index:int=live2DModel.getParamIndex("PARAM_ANGLE_X");
    
    live2DModel.setParamFloat("PARAM_ANGLE_X",value,1);
        
    live2DModel.update();
}

function OnRenderObject () {
    if (live2DModel == null) return;
    live2DModel.draw();
}

