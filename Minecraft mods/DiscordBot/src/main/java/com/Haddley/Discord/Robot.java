package com.Haddley.Discord;

import net.dv8tion.jda.api.JDA;
import net.dv8tion.jda.api.JDABuilder;

public class Robot extends Thread{
	private String token = "NzE0OTU0NTc4ODUyMDUzMDQ2.Xs75Vg.QYIVTuczmDeNDiptxO-ZuE1ModE";
	JDA jda;
	public Robot(){
		
	}
	
	public void run() {
		try {
			jda = new JDABuilder(token).build();
		}
		catch(Exception ext) {
			System.err.println(ext);
		}
	}
}