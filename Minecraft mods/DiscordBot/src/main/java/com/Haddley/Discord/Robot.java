package com.Haddley.Discord;

import java.util.ArrayList;
import java.util.List;

import com.Haddley.Main;

import net.dv8tion.jda.api.AccountType;
import net.dv8tion.jda.api.JDA;
import net.dv8tion.jda.api.JDABuilder;
import net.dv8tion.jda.api.OnlineStatus;
import net.dv8tion.jda.api.entities.Activity;
import net.dv8tion.jda.api.entities.Guild;
import net.dv8tion.jda.api.entities.GuildChannel;
import net.dv8tion.jda.api.entities.TextChannel;

public class Robot extends Thread{
	private String token = "In text file";
	
	public String LiveChatID = "714955523908304967";
	public String LiveConsoleID = "714957455955853313";
	public String GuildID = "420006676503068683";
	public TextChannel LiveChat = null;
	public TextChannel LiveConsole = null;
	
	public JDA jda;
	
	public Robot(){
		try {
			System.out.println("JDA Started!!!");
			jda = new JDABuilder(AccountType.BOT).setToken(token).build();
		}
		catch(Exception ext) {
			System.err.println(ext);
		}
	}
	
	public void update() {

	}
	
	public void run() {
		try {
			
			jda.getPresence().setStatus(OnlineStatus.IDLE);
			jda.getPresence().setActivity(Activity.playing("Mineraft"));
			jda.addEventListener(new DiscordToMinecraft());
			
			if(jda == null)
				System.err.println("JDA is null");
			
			TextChannel LiveChat = Main.bot.jda.getTextChannelById(Main.bot.LiveChatID);
			TextChannel LiveConsole = Main.bot.jda.getTextChannelById(Main.bot.LiveConsoleID);
			
//			LiveChat.sendMessage("Testing chat").queue();
//			LiveConsole.sendMessage("Testing console").queue();
			
			System.out.println("Finnished");
		}
		catch(Exception ext) {
			System.err.println(ext);
		}
	}
}