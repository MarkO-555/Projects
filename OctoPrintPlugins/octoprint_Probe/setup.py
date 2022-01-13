# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

import octoprint.plugin

class ProbePlugin(octoprint.plugin.StartupPlugin,
                  octoprint.plugin.TemplatePlugin):
    def on_after_startup(self):
        self._logger.info("ProbeHello!")

__plugin_name__ = "ProbePlugin"
__plugin_pythoncompat__ = ">=2.7,<4"
__plugin_implementation__ = ProbePlugin()