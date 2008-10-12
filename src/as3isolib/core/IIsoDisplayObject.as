/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 J.W.Opitz, All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/
package as3isolib.core
{
	import as3isolib.bounds.IBounds;
	import as3isolib.data.INode;
	
	import flash.geom.Rectangle;
	
	/**
	 * The IIsoDisplayObject interface defines methods for any base display class needing rendering within an 3D isometric space.
	 */
	public interface IIsoDisplayObject extends INode, IContainer
	{
		//////////////////////////////////////////////////////////////////
		//	BOUNDS
		//////////////////////////////////////////////////////////////////
		
		/**
		 * The object that defines the boundries of the IIsoDisplayObject in 3D isometric space.
		 */
		function get isoBounds ():IBounds;
		
		/**
		 * The traditional screen boundries associated with the IIsoDisplayObject in 2D screen coordinates.
		 */
		function get screenBounds ():Rectangle;
		
		//////////////////////////////////////////////////////////////////
		//	POSITION
		//////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		function get distance ():Number;
		
		function set distance (value:Number):void;
		
		/**
		 * Moves the IIsoDisplayObject to the particular 3D isometric coordinates.
		 * 
		 * @param x The x value in 3D isometric space.
		 * @param y The y value in 3D isometric space.
		 * @param z The z value in 3D isometric space.
		 */
		function moveTo (x:Number, y:Number, z:Number):void;
		
		/**
		 * @private
		 */
		function get x ():Number;
		
		/**
		 * The x value in 3D isometric space.
		 */ 
		function set x (value:Number):void;
		
		/**
		 * @private
		 */
		function get y ():Number;
		
		/**
		 * The y value in 3D isometric space.
		 */ 
		function set y (value:Number):void;
		
		/**
		 * @private
		 */
		function get z ():Number;
		
		/**
		 * The z value in 3D isometric space.
		 */ 
		function set z (value:Number):void;
		
		/**
		 * The x value of the container in screen coordinates relative to the parent container.
		 */
		function get screenX ():Number;
		
		/**
		 * The y value of the container in screen coordinates relative to the parent container.
		 */ 
		function get screenY ():Number;
		
		//////////////////////////////////////////////////////////////////
		//	GEOMETRY
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Resizes the IIsoDisplayObject in 3D isometric coordinates.
		 * 
		 * @param width The width in 3D isometric space.
		 * @param length The length in 3D isometric space.
		 * @param height The height in 3D isometric space.
		 */
		function setSize (width:Number, length:Number, height:Number):void
		
		/**
		 * @private
		 */
		function get width ():Number;
		
		/**
		 * The width in 3D isometric space.
		 */
		function set width (value:Number):void;
		
		/**
		 * @private
		 */
		function get length ():Number;
		
		/**
		 * The length in 3D isometric space.
		 */
		function set length (value:Number):void;
		
		/**
		 * @private
		 */
		function get height ():Number;
		
		/**
		 * The height in 3D isometric space.
		 */
		function set height (value:Number):void;
		
		//////////////////////////////////////////////////////////////////
		//	INVALIDATION
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Flag indicating that one or more of the IIsoDisplayObject's properties are invalidated and will be validated during the next render phase.
		 */
		function get isInvalidated ():Boolean;
		
		/**
		 * Invalidates the position of the IIsoDisplayObject.
		 */
		function invalidatePosition ():void;
		
		//////////////////////////////////////////////////////////////////
		//	CLONE
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Clones the IIsoDisplayObject, copying its dimensional and style properties.
		 * Does not copy the position of the original.
		 * Casting to the original class is necessary to avoid compile-time errors.
		 * 
		 * @return IIsoDisplayObject The clone of the original.
		 */
		function clone ():IIsoDisplayObject;
	}
}