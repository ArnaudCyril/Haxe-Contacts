package;

import Button;
import nme.events.MouseEvent;

//classe de cration des boutons
class ButtonTrial extends Button
{
	private var _bWidth:Float; //la largeur
	private var _bHeight:Float;// la hauteur
	private var _basicColor:Int;// la couleur
	private var _overColor:Int;// la couleur au survol
	private var _downColor:Int;//la couleur au clik
	
	//constructeur du boutton en fnction de sa largeur , sa hauteur et sa couleur
	public function new(buttonWidth:Float, buttonHeight:Float,buttonColor:Int)
	{
		super();
		this.cacheAsBitmap = true;
		_bWidth = buttonWidth;
		_bHeight = buttonHeight;
		_basicColor = buttonColor;
		_overColor = buttonColor;
		_downColor = buttonColor;
		
		DrawButton(_basicColor);// appele la fonction DrawButton
		
	}
	
	
	private function DrawButton(buttonColor:Int):Void
	{
		this.graphics.clear();
		this.graphics.beginFill(buttonColor);
		this.graphics.drawRect( -(_bWidth / 2.0), -(_bHeight / 2.0), _bWidth, _bHeight); 
		// créée un rectagle avec les parametre entre parentheses (x,y,largeur, hauteur)
		this.graphics.endFill();
		
	}

	//fonctions evenementielles (au survol , clic , fin du clic...)
	override public function DefaultOver(overEvent:MouseEvent):Void
	{
		DrawButton(_overColor);
	}
	override public function DefaultOut(outEvent:MouseEvent):Void
	{
		DrawButton(_basicColor);
	}
	override public function DefaultDown(downEvent:MouseEvent):Void
	{
		DrawButton(_downColor);
	}
	override public function DefaultUp(upEvent:MouseEvent):Void
	{
		DrawButton(_overColor);
	}
}