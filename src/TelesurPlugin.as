package {
    import openmultimedia.jwplayer.PluginBase;
    import com.longtailvideo.jwplayer.plugins.IPlugin;
    import com.longtailvideo.jwplayer.plugins.PluginConfig;
    import com.longtailvideo.jwplayer.player.IPlayer;
    import flash.display.DisplayObject;

    CONFIG::debug {
    import net.kgdesignes.utils.Console;
    }

    public class TelesurPlugin extends openmultimedia.jwplayer.PluginBase {
        private static const PLUGIN_ID:String = "multimedia_telesur";

        private static const MEDIO:Object = {
            'es': {
                nombre: 'teleSUR',
                slug: 'telesur',
                api_url: 'http://multimedia.tlsur.net/api/', // se va a cambiar a api.tlsur.net/
                media_url: 'http://media.tlsur.net/',
                streaming: [
                    {
                        nombre: 'teleSUR en vivo',
                        slug: 'telesur-en-vivo',
                        tipo: 'wowza',
                        host : 'streaming.tlsur.net',
                        path: '/blive/',
                        streams : {
                            adaptive: { stream: 'ngrp:balta.stream_all' },
                            original: { stream: 'ngrp:balta.stream' },
                            p360: { stream: 'ngrp:balta.stream_360p' },
                            p160: { stream: 'ngrp:balta.stream_160p' }
                        },
                        protocols: {
                            rtmp: { port: 1935, manifest: '/manifest.f4m' },
                            hls: { port: 1935, playlist: '/playlist.m3u8' },
                            rtsp: { port: 1935 }
                        }
                    }
                ],
                web: {
                    en_vivo: 'http://www.telesurtv.net/el-canal/senal-en-vivo'
                }
            },
            'en': {
                nombre: 'teleSUR',
                slug: 'telesur',
                api_url: 'http://multimedia.tlsur.net/en/api/', // se va a cambiar a api.tlsur.net/
                media_url: 'http://media.tlsur.net/',
                streaming: [
                    {
                        nombre: 'teleSUR en vivo',
                        slug: 'telesur-en-vivo',
                        tipo: 'wowza',
                        host : 'streaming.tlsur.net',
                        path: '/blive/',
                        streams : {
                            adaptive: { stream: 'ngrp:balta.stream_all' },
                            original: { stream: 'ngrp:balta.stream' },
                            p360: { stream: 'ngrp:balta.stream_360p' },
                            p160: { stream: 'ngrp:balta.stream_160p' }
                        },
                        protocols: {
                            rtmp: { port: 1935, manifest: '/Manifest.f4m' },
                            hls: { port: 1935, playlist: '/playlist.m3u8' },
                            rtsp: { port: 1935 }
                        }
                    }
                ],
                web: {
                    en_vivo: 'http://www.telesurtv.net/el-canal/senal-en-vivo'
                }
            },
            'pt': {
                nombre: 'teleSUR',
                slug: 'telesur',
                api_url: 'http://multimedia.tlsur.net/pt/api/', // se va a cambiar a api.tlsur.net/
                media_url: 'http://media.tlsur.net/',
                streaming: [
                    {
                        nombre: 'teleSUR en vivo',
                        slug: 'telesur-en-vivo',
                        tipo: 'wowza',
                        host : 'streaming.tlsur.net',
                        path: '/blive/',
                        streams : {
                            adaptive: { stream: 'ngrp:balta.stream_all' },
                            original: { stream: 'ngrp:balta.stream' },
                            p360: { stream: 'ngrp:balta.stream_360p' },
                            p160: { stream: 'ngrp:balta.stream_160p' }
                        },
                        protocols: {
                            rtmp: { port: 1935, manifest: '/Manifest.f4m' },
                            hls: { port: 1935, playlist: '/playlist.m3u8' },
                            rtsp: { port: 1935 }
                        }
                    }
                ],
                web: {
                    en_vivo: 'http://www.telesurtv.net/el-canal/senal-en-vivo'
                }
            }
        };

        public function TelesurPlugin() {
            super();

            CONFIG::debug {
                Console.log('Instanciating teleSUR Plugin: ', this.id);
            }

            this.id = PLUGIN_ID;
            this.medio = MEDIO;
            this.liveStreamingId = 'telesur-en-vivo';
        }

	override public function initPlugin(player:IPlayer, config:PluginConfig):void {
            CONFIG::debug {
                Console.log('teleSUR Configuration', this.id, config);
            }

            var tmpIcon:DisplayObject;

            tmpIcon = player.skin.getSkinElement("teleSUR", "LiveOnControlbar");

            if ( tmpIcon ) {
                this.liveOnControlbarIcon = tmpIcon;
            }

            tmpIcon = player.skin.getSkinElement("teleSUR", "LiveOffControlbar");

            if ( tmpIcon ) {
                this.liveOffControlbarIcon = tmpIcon;
            }

            tmpIcon = player.skin.getSkinElement("teleSUR", "LiveOnDock");

            if ( tmpIcon ) {
            this.liveOnDockIcon = tmpIcon;
            }

            tmpIcon = player.skin.getSkinElement("teleSUR", "LiveOffDock");

            if ( tmpIcon ) {
                this.liveOffDockIcon = tmpIcon;
            }

            super.initPlugin(player, config);
        }
    }
}