package states 
{
	import core.Config;
	import core.Entity;
	import core.Game;
	import core.Key;
	import core.State;
	import events.AsteroidBreakEvent;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import gameObjects.Asteroid;
	import gameObjects.Bullet;
	import gameObjects.GFX.GFX;
	import gameObjects.GFX.GFXPaw;
	import gameObjects.GFX.GFXShake;
	import gameObjects.Ship;
	import events.PlayerShotEvent;
	import core.Utils;
	import gameObjects.GFX.GFXKaboom;

	public class Play extends State{
		private var _bullets:Vector.<Entity> = new Vector.<Entity>;
		private var _asteroids:Vector.<Entity> = new Vector.<Entity>;
		private var _ship:Ship = new Ship(Config.WORLD_CENTER_X, Config.WORLD_CENTER_Y);
		private var _gfx:Vector.<Entity> = new Vector.<Entity>;
		
		private const ASTEROIDS_SPAWN:Array = [Asteroid.TYPE_BIG, Asteroid.TYPE_BIG, Asteroid.TYPE_MED, Asteroid.TYPE_SMALL];
		
		public var _collision:Sprite = new Sprite();
		
		public function Play(fsm:Game){
			super(fsm);
			_ship.addEventListener(PlayerShotEvent.PLAYER_SHOT, onFire, false, 0, true);
			Key.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			addChild(_collision);
			addEntity(_ship);
			spawnAsteroids();
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		private function onKeyDown(e:KeyboardEvent):void{
			trace("pelle");
			if (e.keyCode == Keyboard.R){
				spawnAsteroids();
			}
		}
		
		private function spawnAsteroids():void{
			for (var i:Number = 0; i < ASTEROIDS_SPAWN.length; i++){
				var freeZoneSize:Number = 120;
				var asteroidX:Number = (Math.random() < 0.5) ? Utils.random(0, _ship.x - freeZoneSize) : Utils.random( _ship.x + freeZoneSize, Config.WORLD_WIDTH);  //could be wrong math..
				var asteroidY:Number = (Utils.random(0, Config.WORLD_HEIGHT));
				addEntity(new Asteroid(asteroidX, asteroidY, ASTEROIDS_SPAWN[i]));
			}
		}
		
		private function onFire(e:PlayerShotEvent):void{
			var b:Bullet = new Bullet(e._x, e._y, e._direction);
			addEntity(new GFXPaw(e._x, e._y));
			addEntity(b);
		}
		
		private function addEntity(e:Entity):void{
			if (e is Bullet){
				_bullets.push(e);
			}else if (e is Asteroid){
				e.addEventListener(AsteroidBreakEvent.ASTEROID_BREAK, onAsteroidsBreak, false, 0, true);
				_asteroids.push(e);
			}else if (e is GFX){
				_gfx.push(e);
			}
			addChild(e);
		}
		
		private function onAsteroidsBreak(e:AsteroidBreakEvent):void{
			var spawnCount:Number = 0;
			var newType:Number = Asteroid.TYPE_MED;
			
			if (e._type == Asteroid.TYPE_BIG){
				spawnCount = 3;
			}else if (e._type == Asteroid.TYPE_MED){
				spawnCount = 2;
				newType = Asteroid.TYPE_SMALL;
			}
			while (spawnCount-- > 0){
				addEntity(new Asteroid(e._x, e._y, newType));
			}
			
			addEntity(new GFXKaboom(e._x, e._y));
			addEntity(new GFXShake());
		}
		
		private function getAllEntities(inclShip:Boolean = false):Vector.<Entity>{
			var entities:Vector.<Entity> = _asteroids.concat(_bullets, _gfx);
			if (inclShip){
				entities.push(_ship);
			}
			return entities;
		}
		
		private function removeDeadEntities(entities:Vector.<Entity>):void{
			var e:Entity;
			for (var i:Number = entities.length - 1; i >= 0; i--){
				e = entities[i];
				if (!e.isAlive()){
					removeChild(e);
					e.destroy();
					entities.removeAt(i);
				}
			}
		}
		
		private function checkCollisions():void{
			var b:Bullet;
			var a:Asteroid;
			for (var i:Number = 0; i < _asteroids.length; i++){
				a = _asteroids[i] as Asteroid;
				for (var j:Number = 0; j < _bullets.length; j++){
					b = _bullets[j] as Bullet;
					if (b.isColliding(a)){
						a.onCollision(b);
						b.onCollision(a);
						break;
					}
				}
				if(a.isColliding(_ship)){
					_ship.onCollision(a);
					a.onCollision(_ship);
					break; //Ship will have lives
				}
			}
		}
		
		private function checkAllDeadEntities():void{
			removeDeadEntities(_bullets);
			removeDeadEntities(_asteroids);
			removeDeadEntities(_gfx);
			if (!_ship.isAlive()){
				_ship.destroy();
				removeChild(_ship);
				//GAME OVER!!
			}
		}
		
		override public function update():void{
			var allEntities:Vector.<Entity> = getAllEntities(true);
			for (var i:Number = 0; i < allEntities.length; i++){ 
				allEntities[i].update();
			}
			checkCollisions();
			checkAllDeadEntities();
		}
		
		
		override public function destroy():void{
			var entities:Vector.<Entity> = getAllEntities(true);
			for (var i:Number = 0; i < entities.length; i++){ 
				entities[i].kill();
			}
			checkAllDeadEntities();
			_ship = null;
			super.destroy();
		}
		
	}

}