package core {
	import starling.display.Sprite;
	import nape.phys.Body;
	import gameObject.Bullet;
	
	/**
	 * @author Andréas Appelqvist
	 */
	public class Entity extends Sprite {
		
		public function set speedX(x:Number):void{ _body.velocity.x = x;}
		public function set speedY(y:Number):void{ _body.velocity.y = y;}
		public function get speedX():Number{ return _body.velocity.x; }
		public function get speedY():Number{ return _body.velocity.x; }
		public function get body():Body{ return _body; }
		
		public override function get rotation():Number{ return _body.rotation; }
		public override function set rotation(rot:Number):void { _body.rotation = rot; }	
		
		public override function set x(x:Number):void{_body.position.x = x; }
		public override function set y(y:Number):void{_body.position.y = y;}	
		public override function get x():Number{return _body.position.x; }
		public override function get y():Number{return _body.position.y; }	
		
		private var _body:Body;
		
		public function Entity(x:Number, y:Number, body:Body) {
			super();
			_body = body;
			_body.position.x = x;
			_body.position.y = y;
		}
		
		public function worldWrap():void{
			if (_body.position.x < 0){
				_body.position.x = Config.worldWidth;
			}else if (_body.position.x > Config.worldWidth){
				_body.position.x = 0;
			}
		}
		
		public function update(deltaTime:Number):void{
			worldWrap();
		}
		
		public function destroy():void{
			_body = null;
		}
		
	}

}