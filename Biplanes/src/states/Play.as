package states {
	import core.State;
	import core.Game;
	import core.Config;
	import core.Util;
	import core.Key;
	import events.ShotEvent;
	import flash.display.Sprite;
	import gameObject.Bullet;
	import gameObject.Cloud;
	import gameObject.Tower;
	import gameObject.plane.Biplane;
	import gameObject.plane.LeftPlane;
	import gameObject.plane.RightPlane;
	import gameObject.Background;
	import manager.ExplosionManager;
	import manager.CollisionManager;
	import manager.SoundManager;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import nape.util.Debug;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import nape.callbacks.CbType;
	import nape.callbacks.CbEvent;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import ui.Pause;
	import ui.Stats;
	
	/**
	 * The play state
	 * @author Andréas Appelqvist
	 */
	public class Play extends State{
		public static var WIN_LEFT:String = "win_left";
		public static var WIN_RIGHT:String = "win_right";
		public static var WIN_TIE:String = "tie";
		
		//Entities
		private var _leftPlane:Biplane;
		private var _rightPlane:Biplane;
		private var _tower:Tower;
		private var _bullets:Vector.<Bullet> = new Vector.<Bullet>;
		private var _clouds:Vector.<Cloud> = new Vector.<Cloud>;

		private var _space:Space;
		
		private var _debug:Debug;
		private var _debugEnable:Boolean = false;
		
		private var _background:Background;
		private var _explosionManager:ExplosionManager;
		private var _collisionManager:CollisionManager;
		
		private var _pauseOverlay:Pause = new Pause();
		private var _statsOverlay:Stats = new Stats();
		
		private var _isPaused:Boolean = false;
		private var _rdyNewPause:Boolean = true;
		
		private var _gameOver:Boolean = false;
		private var _winner:String = "";
		
		public function Play(fsm:Game, sm:SoundManager) {
			super(fsm, sm);
			init();
		}
		
		public function init():void{
			
			if(!_debugEnable){
				_background = new Background(Assets.getBitmap(Config.backgroundSkyWithGround));
				addChild(_background);
			}
		
			//Spawning clouds
			spawnClouds(5);
			
			//Adding stats on display
			addChild(_statsOverlay);
			
			//Adding a space
			var gravity:Vec2 = Vec2.weak(0, 600);
			_space = new Space(gravity);
			
			//Setting up managers
			_collisionManager = new CollisionManager(this, _space);
			_explosionManager = new ExplosionManager(this);
			
			//Add floor
			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(0, Config.worldHeight - 20, Config.worldWidth, 20)));
			_collisionManager.addCollisionListener(_collisionManager.ACTOR_GROUND, floor);
			floor.space = _space;
			
			//Debug
			var tempStage:flash.display.Stage = Starling.current.nativeStage;
			var debugSprite:Sprite = new flash.display.Sprite();
			if (_debug == null && _debugEnable){
				_debug = new BitmapDebug(Config.worldWidth, tempStage.stageHeight, 0xFF0099, true);
				debugSprite.addChild(_debug.display);
				tempStage.addChild(debugSprite);
			}
			
			//Adding every entites
			addEntities();
		}
		
		/**
		 * Create and place starting entities on display
		 */
		private function addEntities():void{
			//leftplane
			_leftPlane = new LeftPlane(_space);
			_leftPlane.addEventListener(ShotEvent.ON_SHOT, onShoot);
			_collisionManager.addCollisionListener(_collisionManager.ACTOR_LPLANE, _leftPlane.body);
			addChild(_leftPlane);
			
			//rightplane
			_rightPlane = new RightPlane(_space);
			_rightPlane.addEventListener(ShotEvent.ON_SHOT, onShoot);
			_collisionManager.addCollisionListener(_collisionManager.ACTOR_RPLANE, _rightPlane.body);
			addChild(_rightPlane);
			
			//tower
			_tower = new Tower(_space);
			_collisionManager.addCollisionListener(_collisionManager.ACTOR_TOWER, _tower.body);
			addChild(_tower);
		}
		
		/**
		 * draw clouds on screen
		 * @param n nbr of clouds
		 */
		private function spawnClouds(n:Number):void{
			var x:Number;
			var y:Number;
			for (var i:Number = 0; i < n; i++){
				x = Util.random(0, Config.worldWidth);
				y = Util.random(10, Config.worldHeight * 0.5);
				var cloud:Cloud = new Cloud(x, y, 0);
				_clouds.push(cloud);
				addChild(cloud);
			}
		}
		
		/**
		 * When a ShotEvent is trigged
		 * @param	e
		 */
		private function onShoot(e:ShotEvent):void{
			var b:Bullet = new Bullet(e._x, e._y, e._direction, _space);
			_soundManager.playShot(e._x);
			_collisionManager.addCollisionListener(_collisionManager.ACTOR_BULLET, b.body);
			_bullets.push(b);
			addChild(b);
		}
		
		/**
		 * Kill a bullet
		 * @param	bulletId
		 */
		public function killBullet(bulletId:Number):void{
			for (var i:Number = 0; i < _bullets.length; i++){
				if (_bullets[i].body.id == bulletId){
					_bullets[i]._isAlive = false;
				}
			}
		}
		
		/**
		 * When a invidual collision occur.
		 * @param	actor who it is
		 * @param	type what type of collision
		 */
		public function invidiualCollision(actor:String, type:String):void{
			if (actor == _collisionManager.ACTOR_RPLANE){
				if (type == _collisionManager.BULLET_TYPE){
					if (_rightPlane.hasTakenOff()){
						rightDead();
					}
				}else if (type == _collisionManager.TOWER_TYPE){
					rightDead();
				}else if (type == _collisionManager.GROUND_TYPE){
					if (_rightPlane.hasTakenOff()){
						rightDead();
					}
				}
			}else{
				if (type == _collisionManager.BULLET_TYPE){
					if (_leftPlane.hasTakenOff()){
						leftDead();
					}
				}else if (type == _collisionManager.TOWER_TYPE){
					leftDead();
				}else if (type == _collisionManager.GROUND_TYPE){
					if (_leftPlane.hasTakenOff()){
						leftDead();
					}
				}
			}
			
			if (_statsOverlay != null){
				_statsOverlay.updateStats(_leftPlane.getLives(), _rightPlane.getLives());
			}
			
		}
		
		/**
		 * Two planes collidie with each other.
		 * Checks for tie.
		 * @param	type
		 */
		public function dualPlaneCollision(type:String):void{
			if (type == _collisionManager.PLANE_COLLISION_TYPE){
				if (_leftPlane.hasTakenOff() && _rightPlane.hasTakenOff()){
					if (_rightPlane.getLives() <= 1 && _leftPlane.getLives() <= 1){
						_rightPlane.decreaseLives();
						_leftPlane.decreaseLives();
						_statsOverlay.updateStats(_leftPlane.getLives(), _rightPlane.getLives());
						_gameOver = true;
						_winner = Play.WIN_TIE;
					}else{
						leftDead();
						rightDead();
					}
				}else{
					if(_leftPlane.hasTakenOff()){
						leftDead();
					}
					if (_rightPlane.hasTakenOff()){
						rightDead();
					}
				}
			}
		}
		
		/**
		 * Kill the left plane.
		 */
		public function leftDead():void{
			_explosionManager.spawnExplosion(_leftPlane.x, _leftPlane.y);
			_soundManager.playExplosion(_leftPlane.x);
			_leftPlane.dead();
			
			if (!_leftPlane.decreaseLives()){
				_gameOver = true;
				_winner = Play.WIN_RIGHT;
			}
		}
		
		/**
		 * Kill right plane
		 */
		public function rightDead():void{
			_explosionManager.spawnExplosion(_rightPlane.x, _rightPlane.y);
			_soundManager.playExplosion(_rightPlane.x);
			_rightPlane.dead();
			
			if (!_rightPlane.decreaseLives()){
				_gameOver = true;
				_winner = Play.WIN_LEFT;
			}
		}
		
		/**
		 * Switch to gameover state.
		 * @param	winner
		 */
		public function gameover(winner:String):void{
			_fsm.changeState(_fsm.GAME_STATE_GAMEOVER, winner);
		}
		
		/**
		 * Resets tower.
		 */
		public function resetTower():void{
			_tower.reset();
		}
		
		/**
		 * Checks if player will pause on unpase
		 */
		public function checkPause():void{
			if (Key.isKeyPressed(Key.PAUSE_P) || Key.isKeyPressed(Key.PAUSE_ESC)){
				if (_rdyNewPause){;
					displayPauseOverlay(!_isPaused);
					_isPaused = !_isPaused;
				}
				_rdyNewPause = false;
			}else{
				_rdyNewPause = true;
			}
		}
		
		/**
		 * Hide or show the pause overlay
		 * @param	show
		 */
		public function displayPauseOverlay(show:Boolean):void{
			if (show){
				addChild(_pauseOverlay);
			}else{
				removeChild(_pauseOverlay);
			}	
		}
		
		/**
		 * Remove all bullets
		 */
		public function removeBullets():void{
			for (var i:Number = _bullets.length - 1; i >= 0; i--){
				removeChild(_bullets[i]);
				_bullets[i].destroy();
				_bullets[i] = null;
			}
		}
		
		/**
		 * remove clouds
		 */
		public function removeClouds():void{
			for (var i:Number = _clouds.length - 1; i >= 0; i--){
				removeChild(_clouds[i]);
				_clouds[i].destroy();
				_clouds[i] = null;
			}
		}
		
		/**
		 * If an engine is running, call the soundmanager to make engine sound.
		 */
		public function engineRunning():void{
			if (_leftPlane.isEngineRunning() || _rightPlane.isEngineRunning() && !_isPaused){
				_soundManager.playEngine();
			}else{
				_soundManager.stopEngine();
			}
			
		}
		
		public override function update(deltaTime:Number):void{
			checkPause();
			engineRunning();
			
			if (_isPaused){
				_leftPlane.pauseTexture();			   //Quick and dirty fix to not step in movieclip-animation at pause
				_rightPlane.pauseTexture();
				if (Key.isKeyPressed(Key.QUIT)){
					_fsm.changeState(_fsm.GAME_STATE_MENU);
				}else if (Key.isKeyPressed(Key.RESTART)){
					_fsm.changeState(_fsm.GAME_STATE_PLAY);
				}
				return;
			}else{
				_leftPlane.resumeTexture();				//And here
				_rightPlane.resumeTexture();
			}
			
			_space.step(deltaTime);
			_leftPlane.update(deltaTime);
			_rightPlane.update(deltaTime);
			_tower.update(deltaTime);
		
			//update and remove dead bullets
			for (var i:Number = _bullets.length - 1; i >= 0; i--){
				_bullets[i].update(deltaTime);
				if (!_bullets[i]._isAlive){
					_collisionManager.removeCollisionListener(_collisionManager.BULLET_TYPE, _bullets[i].body);
					_space.bodies.remove(_bullets[i].body);
					_bullets[i].destroy();
					_bullets.removeAt(i);		
				}
			}
			
			//Move clouds
			for (i = 0; i < _clouds.length; i++){
				_clouds[i].update(deltaTime);
			}
			
			//Debug
			if (_debug != null){
				_debug.clear();
				_debug.draw(_space);
				_debug.flush();
			}
			
			//Gameover?
			if (_gameOver){
				gameover(_winner);
			}
		}
		
		public override function destroy():void{
			_soundManager.stopEngine();
			
			removeBullets();
			
			removeChild(_leftPlane);
			_leftPlane.destroy();
			_leftPlane.dispose();
			_leftPlane = null;
			
			removeChild(_rightPlane);
			_rightPlane.destroy();
			_rightPlane.dispose();
			_rightPlane = null;
			
			removeClouds();
			
			removeChild(_tower);
			_tower.destroy();
			_tower.dispose();
			_tower = null;
			
			if (!_debugEnable){
				_debug = null;
				removeChild(_background);
				_background.destroy();
				_background.dispose();
				_background = null;
			}
			
			_explosionManager.destroy();
			_explosionManager = null;
			
			_collisionManager.destroy();
			_collisionManager = null;
			
			removeChild(_statsOverlay);
			_statsOverlay.destroy();
			_statsOverlay.dispose();
			_statsOverlay = null;
			
			removeChild(_pauseOverlay);
			_pauseOverlay.destroy();
			_pauseOverlay.dispose();
			_pauseOverlay = null;
			
			_space = null;
			
			super.destroy();
		}
		
	}
}