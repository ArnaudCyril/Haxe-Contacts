class ApplicationMain
{

	#if waxe
	static public var frame : wx.Frame;
	static public var autoShowFrame : Bool = true;
	#if nme
	static public var nmeStage : wx.NMEStage;
	#end
	#end
	
	public static function main()
	{
		#if nme
		nme.Lib.setPackage("NME", "Gestionnaire de Contact", "org.haxenme.contacts", "1.0.0");
		
		#end
		
		#if waxe
		wx.App.boot(function()
		{
			
			frame = wx.Frame.create(null, null, "Appli", null, { width: 640, height: 480 });
			
			#if nme
			var stage = wx.NMEStage.create(frame, null, null, { width: 640, height: 480 });
			#end
			
			Contacts.main();
			
			if (autoShowFrame)
			{
				wx.App.setTopWindow(frame);
				frame.shown = true;
			}
		});
		#else
		
		nme.Lib.create(function()
			{ 
				//if ((640 == 0 && 480 == 0) || true)
				//{
					nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
					nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
				//}
				
				var hasMain = false;
				
				for (methodName in Type.getClassFields(Contacts))
				{
					if (methodName == "main")
					{
						hasMain = true;
						break;
					}
				}
				
				if (hasMain)
				{
					Reflect.callMethod (Contacts, Reflect.field (Contacts, "main"), []);
				}
				else
				{
					var instance = Type.createInstance(Contacts, []);
					#if nme
					if (Std.is (instance, nme.display.DisplayObject)) {
						nme.Lib.current.addChild(cast instance);
					}
					#end
				}
			},
			640, 480, 
			30, 
			0,
			(true ? nme.Lib.HARDWARE : 0) |
			(false ? nme.Lib.ALLOW_SHADERS : 0) |
			(false ? nme.Lib.REQUIRE_SHADERS : 0) |
			(false ? nme.Lib.DEPTH_BUFFER : 0) |
			(false ? nme.Lib.STENCIL_BUFFER : 0) |
			(true ? nme.Lib.RESIZABLE : 0) |
			(false ? nme.Lib.BORDERLESS : 0) |
			(false ? nme.Lib.VSYNC : 0) |
			(true ? nme.Lib.FULLSCREEN : 0) |
			(0 == 4 ? nme.Lib.HW_AA_HIRES : 0) |
			(0 == 2 ? nme.Lib.HW_AA : 0),
			"Appli"
			
		);
		#end
		
	}
	
	
	#if neko
	public static function __init__ () {
		
		untyped $loader.path = $array ("@executable_path/", $loader.path);
		
	}
	#end
	
	
	public static function getAsset(inName:String):Dynamic
	{
		#if nme
		
		if (inName == "assets/AndroidManifest.xml")
		{
			
			return nme.Assets.getText ("assets/AndroidManifest.xml");
			
		}
		
		if (inName == "assets/COPYRIGHT.TXT")
		{
			
			return nme.Assets.getText ("assets/COPYRIGHT.TXT");
			
		}
		
		if (inName == "assets/nme2.svg")
		{
			
			return nme.Assets.getText ("assets/nme2.svg");
			
		}
		
		if (inName == "assets/VeraSe.ttf")
		{
			
			return nme.Assets.getFont ("assets/VeraSe.ttf");
			
		}
		
		if (inName == "assets/VeraSeBd.ttf")
		{
			
			return nme.Assets.getFont ("assets/VeraSeBd.ttf");
			
		}
		
		#end
		return null;
	}
	
	
}
