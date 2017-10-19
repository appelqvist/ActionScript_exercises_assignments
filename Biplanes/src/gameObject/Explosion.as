package gameObject {
	import de.flintfabrik.starling.extensions.FFParticleSystem;
	import de.flintfabrik.starling.extensions.FFParticleSystem.styles.FFParticleStyle;
	import de.flintfabrik.starling.extensions.FFParticleSystem.SystemOptions;
	
	/**
	 * Explosion, pang
	 * @author Andréas Appelqvist
	 */
	public class Explosion extends FFParticleSystem {
		
		public function Explosion() {
			var config:SystemOptions = SystemOptions.fromXML(XML(new Assets.ExplosionXML()), Assets.getTexture("explosion")); 
			super(config, null);
		}
		
	}

}