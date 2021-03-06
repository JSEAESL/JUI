﻿CONFIDENTIAL
============================================================
	Live2D Cubism SDK for Flash Version 2.0.04_1

	(c) Live2D Inc.
============================================================

本SDKはFlash上でLive2D Cubismを使用したアプリケーションを
作成するためのソフトウェア開発キットです。

Live2Dライブラリと、サンプルプロジェクトが含まれます。
開発に際しては以下の文章を必ずお読みください。


------------------------------
	ライセンスについて
------------------------------
	本SDKの使用許諾については以下のサイトからご確認ください。
	for business
	http://live2d.com/sdk_license_cubism 

	for indie
	http://live2d.com/sdk_license_cubism_indie


------------------------------
	動作環境
------------------------------
	プログラム言語 : ActionScript3
	ライブラリ形式 : swc
	グラフィック環境 : Stage3D
	対応プラットフォーム : FlashPlayer 11以降, AdobeAIR
	サンプルの開発環境 : FlashDevelop(一部FlashBuilder)


------------------------------
	描画について
------------------------------
	FlashPlayer11以降の機能であるGPUを使った3D描画機能(Stage3D)で描画しています。
	GPUが搭載されていない、またはユーザ設定により使用が許可されていない環境では極端に遅くなる場合があります。


------------------------------
	リリースノート
------------------------------
	最新版についてはこちらからご確認下さい。
	http://sites.google.com/a/cybernoids.jp/cubism-sdk2

	2.0.04_1 (2014/11/18)

	2.0.00_1 (2014/08/28)

	1.0.03_1 (2014/04/21) 
	1.0.02_1 (2014/01/07)
	1.0.01 (2013/07/08)
	1.0.00 (2013/05/21)

	尚、アップデートの際はご登録時のメールアドレスにご案内いたします。


------------------------------
	オンラインマニュアル
------------------------------
	Live2D マニュアル
	http://sites.cybernoids.jp/cubism2/

	Flash 開発チュートリアル
	http://sites.cybernoids.jp/cubism2/sdk_tutorial/platform-setting/flash

	Live2D API リファレンス
	http://doc.live2d.com/api/core/cpp2.0j/


------------------------------
	フォルダ構成
------------------------------
	ReadMe.txt	本ドキュメント
	lib			ライブラリ本体が含まれるフォルダ
	sample		サンプルプロジェクトが含まれるフォルダ
	framework	サンプルで使用しているLive2Dフレームワークのコードが含まれるフォルダ


------------------------------
	サンプルについて
------------------------------
	サンプルプロジェクトがsampleフォルダ以下に含まれます。

	Simple
		最も単純なLive2Dモデル組み込みのサンプルです。
		Live2Dに関する全ての基本処理を１ファイルに記述しています

	SampleApp1
		基本的な機能を実装したサンプルです。
		モーションの再生、表情の設定、ポーズの切り替え、物理演算の設定
		などを行います。
		右クリックメニューからモデルを切り替えることができます

	Benchmark
		Live2Dの表示速度計測のテストプロジェクトです。

	DesctopMascot
		デスクトップ上にLive2Dを表示するサンプルです。
		※このサンプルのみFlexSDKを利用しておりますが、実行の環境に
		　よってはFlexSDKのパスが通らずに実行できないことがあります。
		　その場合は、プロジェクト内のbat/SetupSDK.batのFLES_SDKの値を
		　使用環境のものに修正してください。


------------------------------
	サポートについて
------------------------------
	SDKのサポート・拡張等有償にて承っております。
	ご希望の場合は担当者またはWEBからお問い合わせください。

	http://live2d.com/


------------------------------
	Live2D コミュニティ
------------------------------
	Cubismシリーズを使用中のクリエーターやデベロッパーのためのフォーラムです。
	お気軽にご投稿ください。

	http://forum.live2d.com/
