package manager {
	import flash.display.InteractiveObject;
	import nape.phys.Body;
	import nape.phys.InteractorIterator;
	import nape.space.Space;
	import states.Play;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.CbEvent;
	import nape.callbacks.InteractionType;
	import nape.callbacks.InteractionCallback;
	/**
	 * Listen on all the collision that happens in a space.
	 * @author Andréas Appelqvist
	 */
	public class CollisionManager {
		
		private var _play:Play;
		private var _space:Space;
		
		public const BULLET_TYPE:String = "bullet";
		public const TOWER_TYPE:String = "tower";
		public const GROUND_TYPE:String = "ground";
		public const PLANE_COLLISION_TYPE:String = "plane_collision";
		
		public const ACTOR_RPLANE:String = "right";
		public const ACTOR_LPLANE:String = "left";
		public const ACTOR_BULLET:String = "bullet";
		public const ACTOR_TOWER:String = "tower";
		public const ACTOR_GROUND:String = "ground";
		
		private var _towerCollisionType:CbType = new CbType();
		private var _leftBiplaneCollisonType:CbType = new CbType();
		private var _rightBiplaneCollisonType:CbType = new CbType();
		private var _bulletsCollisonType:CbType = new CbType();
		private var _groundCollisonType:CbType = new CbType();
		
		public function CollisionManager(play:Play, space:Space) {
			_play = play;
			_space = space;
			
			var interactionListener:InteractionListener;
			//Biplanes colide with each other
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _leftBiplaneCollisonType, _rightBiplaneCollisonType, biplaneCollision);
			_space.listeners.add(interactionListener);
			
			//left biplane touches ground
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _leftBiplaneCollisonType, _groundCollisonType, leftground);
			_space.listeners.add(interactionListener);
			
			//left got shot.
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _leftBiplaneCollisonType, _bulletsCollisonType, leftshot);
			_space.listeners.add(interactionListener);
			
			//left collide with tower
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _leftBiplaneCollisonType, _towerCollisionType, lefttower);
			_space.listeners.add(interactionListener);
			
			//right biplane touches ground
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _rightBiplaneCollisonType, _groundCollisonType, rightground);
			_space.listeners.add(interactionListener);
			
			//right got shot.
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _rightBiplaneCollisonType, _bulletsCollisonType, rightshot);
			_space.listeners.add(interactionListener);
			
			//right collide with tower
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _rightBiplaneCollisonType, _towerCollisionType, righttower);
			_space.listeners.add(interactionListener);
			
			//bullet collide with tower
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _bulletsCollisonType, _towerCollisionType, bulletDestroy);
			_space.listeners.add(interactionListener);
			
			//bullet collide with ground
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _bulletsCollisonType, _groundCollisonType, bulletDestroy);
			_space.listeners.add(interactionListener);
			
			//bullet collide with bullet
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _bulletsCollisonType, _bulletsCollisonType, bulletCollision);
			_space.listeners.add(interactionListener);
			
		}
		
		public function removeCollisionListener(actor:String, body:Body):void{
			switch(actor){
				case ACTOR_BULLET:
					body.cbTypes.remove(_bulletsCollisonType);
					break;
				case ACTOR_TOWER:
					body.cbTypes.remove(_towerCollisionType);
					break;
				case ACTOR_RPLANE:
					body.cbTypes.remove(_rightBiplaneCollisonType);
					break;
				case ACTOR_LPLANE:
					body.cbTypes.remove(_leftBiplaneCollisonType);
					break;
				case ACTOR_GROUND:
					body.cbTypes.remove(_groundCollisonType);
				default:
					break;
			}
		}
		
		public function addCollisionListener(actor:String, body:Body):void{
			switch(actor){
				case ACTOR_BULLET:
					body.cbTypes.add(_bulletsCollisonType);
					break;
				case ACTOR_TOWER:
					body.cbTypes.add(_towerCollisionType);
					break;
				case ACTOR_RPLANE:
					body.cbTypes.add(_rightBiplaneCollisonType);
					break;
				case ACTOR_LPLANE:
					body.cbTypes.add(_leftBiplaneCollisonType);
					break;
				case ACTOR_GROUND:
					body.cbTypes.add(_groundCollisonType);
				default:
					break;
			}
		}
		
		private function bulletCollision(collision:InteractionCallback):void{
			_play.killBullet(collision.int1.id);
			_play.killBullet(collision.int2.id);
		}
		
		private function bulletDestroy(collision:InteractionCallback):void{
			_play.killBullet(collision.int1.id);
		}
		
		private function biplaneCollision(collision:InteractionCallback):void{
			_play.dualPlaneCollision(PLANE_COLLISION_TYPE);
		}
		
		private function leftground(collision:InteractionCallback):void{
			_play.invidiualCollision(ACTOR_LPLANE, GROUND_TYPE);
		}
		
		private function rightground(collision:InteractionCallback):void{
			_play.invidiualCollision(ACTOR_RPLANE, GROUND_TYPE);
		}
		
		private function leftshot(collision:InteractionCallback):void{
			_play.invidiualCollision(ACTOR_LPLANE, BULLET_TYPE);
			_play.killBullet(collision.int2.id);
		}
		
		private function lefttower(collision:InteractionCallback):void{
			_play.invidiualCollision(ACTOR_LPLANE, TOWER_TYPE);
		}
		
		private function rightshot(collision:InteractionCallback):void{
			_play.invidiualCollision(ACTOR_RPLANE, BULLET_TYPE);
			_play.killBullet(collision.int2.id);
		}
		
		private function righttower(collision:InteractionCallback):void{
			_play.invidiualCollision(ACTOR_RPLANE, TOWER_TYPE);
		}
		
		public function destroy():void{
			_towerCollisionType = null;
			_leftBiplaneCollisonType = null;
			_rightBiplaneCollisonType = null;
			_bulletsCollisonType = null;
			_groundCollisonType = null;
			_space = null;
			_play = null;
		}
	}

}