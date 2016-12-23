package states 
{
	import core.Config;
	import core.Entity;
	import core.Game;
	import core.Key;
	import core.SimpleSound;
	import core.SoundManager;
	import core.State;
	import events.AsteroidBreakEvent;
	import events.PlayerHitEvent;
	import events.UfoHitEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import gameObjects.Asteroid;
	import gameObjects.Bullet;
	import gameObjects.GFX.GFX;
	import gameObjects.GFX.GFXPaw;
	import gameObjects.GFX.GFXShake;
	import gameObjects.Ship;
	import events.ShotEvent;
	import core.Utils;
	import gameObjects.GFX.GFXKaboom;
	import gameObjects.UFO;
	import ui.Label;
	import ui.GUIPlay;

	public class Play extends State{
		
		private var _bullets:Vector.<Entity> = new Vector.<Entity>;
		private var _ufoBullets:Vector.<Entity> = new Vector.<Entity>;
		private var _asteroids:Vector.<Entity> = new Vector.<Entity>;
		private var _ship:Ship = new Ship(Utils.getWorldCenter().x, Utils.getWorldCenter().y);
		private var _ufo:UFO;
		private var _gfx:Vector.<Entity> = new Vector.<Entity>;
		private var _shipLivesLeft:Number;
		private var _score:Number = 0;
		private var _running:Boolean = true;
		private var _guiOverLay:GUIPlay = new GUIPlay();
		
		private const ASTEROIDS_SPAWN:Array = [Asteroid.TYPE_LARGE, Asteroid.TYPE_MED];
		
		public function Play(fsm:Game, _soundManager:SoundManager){
			super(fsm, _soundManager);	
			_shipLivesLeft = Config.getNumber("tot_lives", ["entities", "ship"]);
			_ship.addEventListener(ShotEvent.ON_SHOT, onFire, false, 0, true);
			_ship.addEventListener(PlayerHitEvent.PLAYER_HIT, onShipGotHit, false, 0, true);
			Key.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			_guiOverLay.x = this.x;
			_guiOverLay.y = this.y;
			addChild(_guiOverLay);
			addEntity(_ship);	
		}
		
		private function addEntity(e:Entity):void{
			if (e is Bullet){
				_bullets.push(e);
			}else if (e is Asteroid){
				e.addEventListener(AsteroidBreakEvent.ASTEROID_BREAK, onAsteroidsBreak, false, 0, true);
				_asteroids.push(e);
			}else if (e is GFX){
				_gfx.push(e);
			}else if (e is UFO){
				_ufo.addEventListener(ShotEvent.ON_SHOT, onFire, false, 0, true);
				_ufo.addEventListener(UfoHitEvent.UFO_HIT, onUfoHit, false, 0, true);
			}
			addChild(e);
			swapChildren(_guiOverLay, e); //The overlay always highest
		}
		
		private function onKeyDown(e:KeyboardEvent):void{
			if (e.keyCode == Keyboard.R){
				spawnAsteroids();
			}
		}
		
		private function spawnAsteroids():void{
			for (var i:Number = 0; i < ASTEROIDS_SPAWN.length; i++){
				var freeZoneSize:Number = 120;
				var asteroidX:Number = (Math.random() < 0.5) ? Utils.random(0, _ship.x - freeZoneSize) : Utils.random( _ship.x + freeZoneSize, Config.getNumber("width", ["world"]));
				var asteroidY:Number = (Utils.random(0, Config.getNumber("height", ["world"])));
				addEntity(new Asteroid(asteroidX, asteroidY, ASTEROIDS_SPAWN[i]));
			}
		}
		
		private function onFire(e:ShotEvent):void{
			var b:Bullet = new Bullet(e._x, e._y, e._direction);
			if (e._enemyBullet){
				addChild(b);
				_ufoBullets.push(b);
			}else{
				addEntity(b);
			}
			addEntity(new GFXPaw(e._x, e._y));
			_soundManager.playShoot();
		}
		
		private function onShipGotHit(e:PlayerHitEvent):void{
			_soundManager.playHit();
			_shipLivesLeft--;
			if (_shipLivesLeft > 0){
				_guiOverLay.removeLive();
			}else{
				_ship.kill();
			}
		}
		
		private function onUfoHit(e:UfoHitEvent):void{
			_ufo.removeEventListener(UfoHitEvent.UFO_HIT, onUfoHit);
			_soundManager.playExplosion();
			_score += 100;
			_guiOverLay.updateScore(_score);
			addEntity(new GFXKaboom(e._x, e._y));
			addEntity(new GFXShake());
			
		}
				
		private function onAsteroidsBreak(e:AsteroidBreakEvent):void{
			var newType:String = Config.getSettings("child_type", ["entities", "asteroids", e._type]);
			var nrOfNew:Number = Config.getNumber("child_count", ["entities","asteroids",e._type]);
			
			for (var i:Number = 0; i < nrOfNew; i++){
				addEntity(new Asteroid(e._x, e._y, newType));
			}
			_score += 2;
			_soundManager.playExplosion();
			_guiOverLay.updateScore(_score);
			addEntity(new GFXKaboom(e._x, e._y));
			addEntity(new GFXShake());
		}
		
		private function getAllEntities(inclShip:Boolean = false):Vector.<Entity>{
			var entities:Vector.<Entity> = _asteroids.concat(_bullets, _gfx, _ufoBullets);
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
					if (_ufo != null && _ufo.isColliding(b)){
						_ufo.onCollision(b);
						b.onCollision(_ufo);
						break;
					}
				}
				if(a.isColliding(_ship)){
					_ship.onCollision(a);
					a.onCollision(_ship);
					break; 
				}
			}
	
			if(_ufo != null && _ufo.isAlive()){
				for (i = 0; i < _bullets.length; i++){
					b = _bullets[i] as Bullet;
					if (_ufo.isColliding(b)){
						_ufo.onCollision(b);
						b.onCollision(_ufo);
						break;
					}
				}
				
				if (_ship.isColliding(_ufo)){
					_ship.onCollision(_ufo);
					_ufo.onCollision(_ship);
				}
			}
			
			for (i = 0; i < _ufoBullets.length; i++){
				b = _ufoBullets[i] as Bullet;
				if (b.isColliding(_ship)){
					_ship.onCollision(b);
					b.onCollision(_ship);
					break;
				}
			}
		}
		
		private function checkAllDeadEntities():void{
			removeDeadEntities(_bullets);
			removeDeadEntities(_asteroids);
			removeDeadEntities(_gfx);
			removeDeadEntities(_ufoBullets);
		
			if (_ufo != null && !_ufo.isAlive()){
				removeChild(_ufo);
				_ufo.removeEventListener(ShotEvent.ON_SHOT, onFire);
				_ufo.destroy();
				_ufo = null;
			}
			
			if (!_ship.isAlive()){
				_running = false;
			}
		}
		
		override public function update():void{
			
			if (_asteroids.length < 5){
				spawnAsteroids();
			}
			
			var allEntities:Vector.<Entity> = getAllEntities(true);
			for (var i:Number = 0; i < allEntities.length; i++){ 
				allEntities[i].update();
			}
			
			if (_ufo != null){
				_ufo.update();
			}else{
				var random:Number = Utils.random(0, 1500);
				if (random < Config.getNumber("chance_of_spawn", ["entities", "ufo"])){
					_ufo = new UFO(0, 0, _ship);
					addEntity(_ufo);
				}
			}
			
			checkCollisions();
			checkAllDeadEntities();
			if (!_running){
				_fsm.changeState(Game.GAME_STATE_GAMEOVER, _score);
			}
		}
		
		override public function destroy():void{
			var entities:Vector.<Entity> = getAllEntities(true);
			for (var i:Number = 0; i < entities.length; i++){ 
				entities[i].kill();
			}
			checkAllDeadEntities();
			
			_guiOverLay.destroy();
			removeChild(_guiOverLay);
			_guiOverLay = null;
			
			_ship.removeEventListener(ShotEvent.ON_SHOT, onFire);
			_ship.removeEventListener(PlayerHitEvent.PLAYER_HIT, onShipGotHit);
			super.destroy();
		}	
	}
}