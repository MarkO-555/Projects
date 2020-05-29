package com.Haddley.Discord;

import net.minecraftforge.common.MinecraftForge;

public class MinecraftToDiscord{
	MinecraftToDiscord(){
		MinecraftForge.EVENT_BUS.register(this);
	}
	

	
}
