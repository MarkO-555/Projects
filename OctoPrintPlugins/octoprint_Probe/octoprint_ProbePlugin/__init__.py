# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

import octoprint.plugin

class ProbePlugin(octoprint.plugin.StartupPlugin,
                       octoprint.plugin.TemplatePlugin,
                       octoprint.plugin.SettingsPlugin,
                       octoprint.plugin.AssetPlugin):
    def on_after_startup(self):
        self._logger.info("ProbePlugin!")

    #def get_settings_defaults(self):
    #    return dict(url="https://en.wikipedia.org/wiki/Hello_world")
    
    def get_assets(self):
         return dict(js=["js/ProbePlugin.js"])
         
__plugin_name__ = "ProbePlugin"
__plugin_pythoncompat__ = ">=2.7,<4"
__plugin_implementation__ = ProbePlugin()