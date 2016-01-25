/**
 * 
 */
package freeSlotTrackDesigner;

import java.io.File;
import java.util.Scanner;

/**
 * @author dviejo
 *
 */
public class Tracker2000Parser {

	private String fileNameInput, fileNameOutput; 
	
	public Tracker2000Parser(String fileName)
	{
		Scanner myScanner;
		int posExtension;
		
		if(fileName!=null)
			fileNameInput = fileName;
		else
		{
			System.out.println("Input file not specified. Please type input file (Tracker 2000 format) path:");
			myScanner = new Scanner(System.in);
			fileNameInput = myScanner.nextLine();
		}
		posExtension = fileNameInput.lastIndexOf('.');
		if(posExtension ==-1) fileNameOutput = fileNameInput + ".scad";
		else fileNameOutput = fileNameInput.substring(0, posExtension) + ".scad";
		
		System.out.println("OpenScad data will be stored in "+fileNameOutput);
	}
	
	public int run()
	{
		File inputFile, outputFile;
		return 0;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String ficEntrada = null;
		Tracker2000Parser parser;
		
		//Obtenemos el nombre del fichero
		if(args.length==1) ficEntrada = args[0];

		parser = new Tracker2000Parser(ficEntrada);
		parser.run();
		
	}

}
