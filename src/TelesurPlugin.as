package {
    import openmultimedia.jwplayer.PluginBase;

    public class TelesurPlugin extends openmultimedia.jwplayer.PluginBase {
        private var id_:String = CONFIG::debug ? 'telesur' : 'telesur.min';

        override public function get id():String {
            return this.id_;
        }
    }
}