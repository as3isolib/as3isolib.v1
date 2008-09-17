package as3isolib.renderer
{
	import as3isolib.core.data.INode;
	import as3isolib.display.IRenderer;

	public interface ISceneRendererClient extends IRenderer, INode
	{
		function get renderer ():ISceneRenderer;
		function set renderer (value:ISceneRenderer):void;
	}
}