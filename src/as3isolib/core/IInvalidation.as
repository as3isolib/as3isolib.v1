package as3isolib.core
{
	public interface IInvalidation
	{
		/**
		 * Flag indicating if the scene is invalidated.  If true, validation will occur during the next render pass.
		 */
		function get isInvalidated ():Boolean;
	}
}