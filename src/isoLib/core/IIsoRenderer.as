package isoLib.core
{
	import flash.display.Graphics;
	
	import isoLib.core.sceneGraph.INode;
	
	public interface IIsoRenderer
	{		
		function render():void;
		
		function reposition ():void;
	}
}