package isoLib.primitive
{
	import flash.display.Graphics;
	
	public interface IIsoRenderer
	{		
		function renderWireframe ():void;
		function renderSolid ():void;
		function renderShaded ():void;
		
		function reposition ():void;
	}
}