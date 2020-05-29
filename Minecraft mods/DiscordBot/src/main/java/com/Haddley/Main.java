package com.Haddley;

import java.util.Collections;
import java.util.Map;

import com.Haddley.Discord.Robot;
import com.Haddley.Proxy.CommonProxy;
import com.Haddley.Util.Reference;
import com.google.common.collect.Maps;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.Mod.EventHandler;
import net.minecraftforge.fml.common.Mod.Instance;
import net.minecraftforge.fml.common.SidedProxy;
import net.minecraftforge.fml.common.event.FMLInitializationEvent;
import net.minecraftforge.fml.common.event.FMLPostInitializationEvent;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;
import net.minecraftforge.fml.common.event.FMLServerStartingEvent;

import net.minecraft.command.ICommandManager;
import net.minecraft.command.ICommandSender;

import net.minecraft.server.MinecraftServer;
import net.minecraft.world.World;

@Mod(modid = Reference.MOD_ID, name = Reference.NAME, version = Reference.VERSION)
public class Main {
	@Instance
	public static Main instance;
	public static Robot bot;
	public static MinecraftServer Server;
	public static boolean running = true;
	
	@SidedProxy(clientSide = Reference.CLIENT_PROXY_CLASS, serverSide = Reference.Server_PROXY_CLASS)
	public static CommonProxy proxy;
	
	@EventHandler
	public static void PreInit(FMLPreInitializationEvent event) {
		bot = new Robot();
	}
	
	@EventHandler
	public static void Init(FMLInitializationEvent event) {
	}
	
	@EventHandler
	public static void PostInit(FMLPostInitializationEvent event) {
		
	}
	
	@EventHandler
    public void serverStart(FMLServerStartingEvent event) {
		bot.start();
		Server = event.getServer();

		String command = "say hi 1";
		doCommand(command);
    }

	private Object[] doCommand(String command) {
		  if (Main.Server != null && Main.Server.isCommandBlockEnabled()) {
			Map output = Maps.newHashMap();
		    ICommandManager commandManager = Main.Server.getCommandManager();
		    try {
		      output.clear();
		      int result = commandManager.executeCommand(new comp(), command);
		      return new Object[]{result > 0, Maps.newHashMap(output)};
		    }
		    catch (Exception ext) {
		    	System.out.println("Error");
		    	System.out.println(ext);
		    	return null;
		    }
		  }
		  return new Object[]{false, Collections.singletonMap(1, ("Command blocks disabled by server"))};
	}
}

class comp implements ICommandSender{

	@Override
	public boolean canUseCommand(int arg0, String arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public World getEntityWorld() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MinecraftServer getServer() {
		// TODO Auto-generated method stub
		return null;
	}
	
}