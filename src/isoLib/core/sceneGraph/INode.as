package isoLib.core.sceneGraph
{
	import flash.display.Sprite;
	
	public interface INode
	{
		function get id ():String;
		function set id (value:String):void;
		
		function get parent ():INode;
		
		function get hasParent ():Boolean;
		
		function get numChildren ():uint;
		
		function get container ():Sprite;
		
		function addChild (child:INode):void;
		
		function removeChild (child:INode):INode;
		function removeChildAt (index:uint):INode;
		function removeChildByID (id:String):INode;
		
		function removeAllChildren ():void;
		
		function render (recursive:Boolean = true):void;
	}
}