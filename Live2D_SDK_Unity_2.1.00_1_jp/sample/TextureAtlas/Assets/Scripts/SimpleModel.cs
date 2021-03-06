﻿using UnityEngine;
using System;
using System.Collections;
using live2d;

[ExecuteInEditMode]
public class SimpleModel : MonoBehaviour 
{
    public TextAsset layoutFile;
    public TextAsset mocFile;
    public Texture2D textureFile;
	
	private Live2DModelUnity live2DModel;
    private TextureAtlasLayout layout;
    private Matrix4x4 live2DCanvasPos;
	
	void Start () 
	{
		Live2D.init();

        load();
	}


    void load()
    {
        live2DModel = Live2DModelUnity.loadModel(mocFile.bytes);


        live2DModel.setTexture(0, textureFile);

        layout = TextureAtlasLayout.loadJson(layoutFile.bytes);

        var frames = layout.getFrames();
        int n = frames.Count;
        for (int i = 0; i < n; i++)
        {
            var item=frames[i];
            setTextureMap(i, 0, layout.width,layout.height,item.srcWidth, item.srcHeight, item.x, item.y, item.trimX, item.trimY);
        }


        float modelWidth = live2DModel.getCanvasWidth();
        live2DCanvasPos = Matrix4x4.Ortho(0, modelWidth, modelWidth, 0, -50.0f, 50.0f);
    }

    private void setTextureMap(int srcIndex, int dstIndex,int atlasW,int atlasH, int srcW, int srcH, int x, int y, int trimX, int trimY)
    {
        float scaleX = (float)srcW / atlasW;
        float scaleY = (float)srcH / atlasH;

        float offsetX = (float)(x - trimX) / atlasW;
        float offsetY = (float)(y - trimY) / atlasH;

        live2DModel.setTextureMap(srcIndex, dstIndex, scaleX, scaleY, offsetX, offsetY);
    }


    void Update()
    {
        if (live2DModel == null) load();
        live2DModel.setMatrix(transform.localToWorldMatrix * live2DCanvasPos);

        if (!Application.isPlaying)
        {
            live2DModel.update();
            return;
        }

        double timeSec = UtSystem.getUserTimeMSec() / 1000.0;
        double t = timeSec * 2 * Math.PI;
        live2DModel.setParamFloat("PARAM_ANGLE_X", (float)(30f * Math.Sin(t / 3.0)));


        live2DModel.update();
    }

	
	void OnRenderObject()
	{
        if (live2DModel == null) load();
		live2DModel.draw();
	}
}