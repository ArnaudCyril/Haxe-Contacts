package;

import nme.display.Sprite;
import nme.events.MouseEvent;

//classe contructrice d'un bouton
class Button extends Sprite
{
	private var _mouseOver:Dynamic;
	private var _mouseOut:Dynamic;
	private var _mouseUp:Dynamic;
	private var _mouseDown:Dynamic;
	private var _mouseClick:Dynamic;
	private var _mouseDoubleClick:Dynamic;
	
	public function new()
	{
		super();
		//fonction constructice
		_mouseOver = DefaultOver;
		_mouseOut = DefaultOut;
		_mouseUp = DefaultUp;
		_mouseDown = DefaultDown;
		_mouseClick = DefaultClick;
		_mouseDoubleClick = DefaultDoubleClick;
		
		this.addEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, _mouseOut);
		this.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
		this.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
		this.addEventListener(MouseEvent.CLICK, _mouseClick);
		this.addEventListener(MouseEvent.DOUBLE_CLICK, _mouseDoubleClick);
		
	}
	//initialisation fonction evenementielles 
	public function DefaultOver(overEvent:MouseEvent):Void
	{
	}
	public function DefaultOut(outEvent:MouseEvent):Void
	{
	}
	public function DefaultUp(upEvent:MouseEvent):Void
	{
	}
	public function DefaultDown(downEvent:MouseEvent):Void
	{
	}
	public function DefaultClick(clickEvent:MouseEvent):Void
	{
	}
	public function DefaultDoubleClick(doubleClickEvent:MouseEvent):Void
	{
	}
	
	//fonctions permettant de définir certaines propriétés d'interaction avec la souris
	public var MouseOver(getMouseOver, setMouseOver):Dynamic;
	private function getMouseOver():Dynamic
	{
		return _mouseOver;
	}
	private function setMouseOver(freshOver:Dynamic):Dynamic
	{
		this.removeEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
		_mouseOver = freshOver;
		this.addEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
		return _mouseOver;
	}
	
	public var MouseOut(getMouseOut, setMouseOut):Dynamic;
	private function getMouseOut():Dynamic
	{
		return _mouseOut;
	}
	private function setMouseOut(freshOut:Dynamic):Dynamic
	{
		this.removeEventListener(MouseEvent.MOUSE_OUT, _mouseOut);
		_mouseOut = freshOut;
		this.addEventListener(MouseEvent.MOUSE_OUT, _mouseOut);
		return _mouseOut;
	}
	
	public var MouseUp(getMouseUp, setMouseUp):Dynamic;
	private function getMouseUp():Dynamic
	{
		return _mouseUp;
	}
	private function setMouseUp(freshUp:Dynamic):Dynamic
	{
		this.removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
		_mouseUp = freshUp;
		this.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
		return _mouseUp;
	}
	
	public var MouseDown(getMouseDown, setMouseDown):Dynamic;
	private function getMouseDown():Dynamic
	{
		return _mouseDown;
	}
	private function setMouseDown(freshDown:Dynamic):Dynamic
	{
		this.removeEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
		_mouseDown = freshDown;
		this.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
		return _mouseDown;
	}
	
	public var MouseClick(getMouseClick, setMouseClick):Dynamic;
	private function getMouseClick():Dynamic
	{
		return _mouseClick;
	}
	private function setMouseClick(freshClick:Dynamic):Dynamic
	{
		this.removeEventListener(MouseEvent.CLICK, _mouseClick);
		_mouseClick = freshClick;
		this.addEventListener(MouseEvent.CLICK, _mouseClick);
		return _mouseClick;
	}
	
	public var MouseDoubleClick(getMouseDoubleClick, setMouseDoubleClick):Dynamic;
	private function getMouseDoubleClick():Dynamic
	{
		return _mouseDoubleClick;
	}
	private function setMouseDoubleClick(freshDoubleClick:Dynamic):Dynamic
	{
		this.removeEventListener(MouseEvent.DOUBLE_CLICK, _mouseDoubleClick);
		_mouseDoubleClick = freshDoubleClick;
		this.addEventListener(MouseEvent.DOUBLE_CLICK, _mouseDoubleClick);
		return _mouseDoubleClick;
		
	}
}