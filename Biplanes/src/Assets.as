package {
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import gameObject.Bullet;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import de.flintfabrik.starling.extensions.FFParticleSystem;
	import de.flintfabrik.starling.extensions.FFParticleSystem.styles.FFParticleStyle;
	import de.flintfabrik.starling.extensions.FFParticleSystem.rendering.FFParticleEffect;
	
	public class Assets {
		[Embed(source = "assets/OstrichSans-Heavy.otf",
		fontName = "Ostrich",
		mimeType = "application/x-font",
		advancedAntiAliasing = "true",
		unicodeRange = "U+0020-U+0021, U+002d, U+002f-U+003a, U+0041-U+005a",
		embedAsCFF = "false"
		)]
		private static const OstrichClass:Class;
		
		[Embed(source = "../bin/assets/bg_menu.jpg")]
		public static const BgSky:Class;
		
		[Embed(source = "../bin/assets/bg_play.png")]
		public static const BgSkyG:Class;
		
		[Embed(source = "../bin/assets/tower.png")]
		public static const TowerImage:Class;
		
		[Embed(source = "../bin/assets/bullet.png")]
		public static const BulletImage:Class;
		
		[Embed(source = "../bin/assets/cloud1.png")]
		public static const CloudImage1:Class;
		
		[Embed(source = "../bin/assets/cloud2.png")]
		public static const CloudImage2:Class;
		
		[Embed(source = "../bin/assets/cloud3.png")]
		public static const CloudImage3:Class;
		
		[Embed(source = "../bin/assets/explosion_particle_texture.png")]
		public static var Explosion:Class;
		
		[Embed(source = "../bin/assets/particle_explosion.pex", mimeType="application/octet-stream")]
		public static var ExplosionXML:Class;
		
		[Embed(source = "../bin/assets/biplane_spritesheet.png")]
		public static const Biplane_spritesheet:Class;
		
		/* Spritesheet for detailed biplane sprites*/
		private static var BiplaneTextureAtlas:TextureAtlas;
		
		[Embed(source = "../bin/biplane_spritesheet.xml", mimeType = "application/octet-stream")]
		public static const AtlasXmlBiplane:Class;
		
		public static function getBiplaneAtlas():TextureAtlas{
			if (BiplaneTextureAtlas == null){
				var texture:Texture = getTexture("biplaneSpritesheet");
				var xml:XML = XML(new AtlasXmlBiplane());
				
				BiplaneTextureAtlas = new TextureAtlas(texture, xml);
			}
			return BiplaneTextureAtlas;
		}
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		public static function getTexture(name:String):Texture{
			if (gameTextures[name] == undefined){
				var bitmap:Bitmap = getBitmap(name);
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		public static function initFFParticleSystem():void{
			
			FFParticleSystem.defaultStyle = FFParticleStyle;
			if (!FFParticleSystem.poolCreated){
				FFParticleSystem.initPool(1500, false);
				if (!FFParticleEffect.buffersCreated){
					FFParticleEffect.createBuffers(1500, 2); 
					
				} 
			} 
		}
		
		public static function getBitmap(name:String):Bitmap{
			switch(name){
				case "biplaneSpritesheet":
					return new Biplane_spritesheet as Bitmap;
				case "bgsky":
					return new BgSky as Bitmap;
				case "bgsky_g":
					return new BgSkyG as Bitmap;
				case "tower":
					return new TowerImage as Bitmap;
				case "explosion":
					return new Explosion as Bitmap;
				case "bullet":
					return new BulletImage as Bitmap;
				case "cloud1":
					return new CloudImage1 as Bitmap;
				case "cloud2":
					return new CloudImage2 as Bitmap;
				case "cloud3":
					return new CloudImage3 as Bitmap;
				default: 
					return null;
			}
		}
	}
}