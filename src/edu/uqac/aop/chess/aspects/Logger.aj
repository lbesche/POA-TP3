package edu.uqac.aop.chess.aspects;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import org.aspectj.lang.annotation.*;

import edu.uqac.aop.chess.agent.*;

public aspect Logger {
	public static BufferedWriter writer;
	
	@Pointcut("call(* *.play())")
    public void startGame() {}
	
	@Before("startGame()")
    public void initWriter() {
		try {
			writer = new BufferedWriter(new FileWriter("log.txt"));
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
	
	@AfterReturning(pointcut="execution(Move *.makeMove())",returning="move")
    public void logMove(Move move) {
		try {
			writer = new BufferedWriter(new FileWriter("log.txt", true));
		    writer.append(move.toString());
		    writer.append('\n');
		    writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
//	@After("startGame()")
//	public void closeWriter() {
//    	try {
//			writer.close();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//    }
}
