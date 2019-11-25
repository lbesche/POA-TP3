package edu.uqac.aop.chess.aspects;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;

import edu.uqac.aop.chess.*;
import edu.uqac.aop.chess.agent.*;

public aspect Validation {
	@Pointcut("call(boolean *.makeMove(edu.uqac.aop.chess.agent.Move))")
	public void movePiece() {
	}

	@Before("movePiece()")
	public void checkMove(ProceedingJoinPoint joinPoint) {
		Player player = (Player) joinPoint.getTarget();
		Move mv = (Move) joinPoint.getArgs()[0];
		Board playground = player.getPlayGround();
		if (!(mv == null) && mv.xI < 8 && mv.yI < 8 && mv.xF < 8 && mv.yF < 8 && mv.xI >= 0 && mv.yI >= 0 && mv.xF >= 0
				&& mv.yF >= 0) {
			if (!playground.getGrid()[mv.xI][mv.yI].isOccupied()) {
				System.out.println("La case de d�part s�lectionn�e est vide");
			} else {
				if (playground.getGrid()[mv.xI][mv.yI].getPiece().getPlayer() == player.getColor()) {
					System.out.println("La pi�ce s�lectionn�e appartient au joueur adverse");
				} else {
					if (!playground.getGrid()[mv.xI][mv.yI].getPiece().isMoveLegal(mv)) {
						System.out.println("Ce d�placement est impossible pour la pi�ce s�lectionn�e");
					}
				}
			}
		} else {
			System.out.println("Entr�e non valide");
		}
	}

//	@Around("movePiece()")
//	public Object checkMove2(ProceedingJoinPoint joinPoint) {
//		Player player = (Player)joinPoint.getTarget();
//		Move mv = (Move)joinPoint.getArgs()[0];
//		Board playground = player.getPlayGround();
//		if(!(mv == null) &&
//				playground.getGrid()[mv.xI][mv.yI].isOccupied() &&
//				playground.getGrid()[mv.xI][mv.yI].getPiece().getPlayer() != player.getColor() &&
//				playground.getGrid()[mv.xI][mv.yI].getPiece().isMoveLegal(mv)) {
//			try {
//				joinPoint.proceed();
//				return true;
//			} catch (Throwable e) {
//				e.printStackTrace();
//			}
//		}
//		else {
//			System.out.println("D�placement non valide");
//		}
//		return false;
//	}
}
