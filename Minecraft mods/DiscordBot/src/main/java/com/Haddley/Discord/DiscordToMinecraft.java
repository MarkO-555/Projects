package com.Haddley.Discord;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import com.Haddley.Main;
import com.google.common.collect.Maps;

import net.dv8tion.jda.api.events.message.guild.GuildMessageReceivedEvent;
import net.dv8tion.jda.api.hooks.ListenerAdapter;
import net.minecraft.command.ICommand;
import net.minecraft.command.ICommandManager;
import net.minecraft.command.ICommandSender;
import net.minecraft.server.MinecraftServer;
import net.minecraft.world.World;

public class DiscordToMinecraft extends ListenerAdapter{
	public void onGuildMessageReceived(GuildMessageReceivedEvent event) {
//		System.out.println("Messaged: "+event.getChannel().getId()+" | "+Main.bot.LiveChatID+" | "+Main.bot.LiveConsoleID);
		if(Main.running && !event.getAuthor().isBot() && (event.getChannel().getId().equals(Main.bot.LiveChatID) || event.getChannel().getId().equals(Main.bot.LiveConsoleID))) {
//			send server message or maybe execute a /tellraw @a

//			chatlist cha = new chatlist();
			
			
//			Main.Server.getCommandManager().executeCommand(cha, command);

			
//			Main.Server.createCommandManager().executeCommand(cha, command);
//			Main.Server.getCommandManager();
			
//			command = "say hi 2";
//			Main.Server.getCommandManager().executeCommand(cha(), command);
		}
	}
	
	
}