/**
 * 
 */
package freeSlotTrackDesigner;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.StreamTokenizer;
import java.util.ArrayList;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;

/**
 * @author dviejo
 *
 */
public class Tracker2000Parser {

	private String fileNameInput, fileNameOutput; 
	private ArrayList<TramoPista> listaTramos;
	Map<String, Map<Integer, TramoPista>> fabricantes;
	
	public Tracker2000Parser(String fileName)
	{
		Scanner myScanner;
		int posExtension;
		listaTramos = new ArrayList<TramoPista>();
		
		//creamos el conjunto de fabricantes
		fabricantes = new TreeMap<String, Map<Integer,TramoPista>>();
		
		//NINCO
		Map<Integer, TramoPista> ninco = new TreeMap<Integer,TramoPista>();
		ninco.put(10102, TramoPista.nincoRectaStd);
		ninco.put(10103, TramoPista.nincoRectaMedia);
		ninco.put(10104, TramoPista.nincoRectaCuarto);
		ninco.put(10105, TramoPista.nincoCurvaEstandar);
		ninco.put(10112, TramoPista.nincoCurvaEstandarMedia);
		ninco.put(10106, TramoPista.nincoCurvaInterior);
		ninco.put(10113, TramoPista.nincoCurvaInteriorMedia);
		ninco.put(10107, TramoPista.nincoCurvaExterior);
		ninco.put(10108, TramoPista.nincoCurvaSuperExterior);
		
		fabricantes.put("NINCO", ninco);
		
		
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
		File outputFile;
		FileReader inputFile;
		StreamTokenizer st;
		int token;
		int cont, numTramos;
		int codigoTramo = -1;
		TramoPista tramoActual;
		int status;
		int numTRACKS = -1; //valor 'number of TRACKS' del formato tr3
		String fabricante;
		Map<Integer, TramoPista> pistas = new TreeMap<Integer,TramoPista>();
		int errorCode = 0;
		
		float longIzdo, longDcho;
		longIzdo = longDcho = 0f;
		
		try {
			inputFile = new FileReader(fileNameInput);
			st = new StreamTokenizer(inputFile);
			st.commentChar('#');
			//leemos la cabecera
			fabricante = leerCadena(st);
			if(fabricante!=null)
			{
				pistas = fabricantes.get(fabricante);
				if(pistas!=null)
				{
					//leemos y desechamos los offsets
					if(leerFloat(st)!=-1&&leerFloat(st)!=-1)
					{
						//leemos el numero de pistas
						//TODO soportar un numero mayor a 1
						numTRACKS = leerEntero(st);
						if(numTRACKS==1)
						{
							//leemos y desechamos el angulo y el grupo
							leerEntero(st);
							leerFloat(st);
							leerFloat(st);
							leerEntero(st);
							//leemos el numero de tramos
							numTramos = leerEntero(st);
							if(numTramos>0)
							{
								for(cont=0;cont<numTramos&&errorCode==0;cont++)
								{
									codigoTramo = leerEntero(st);
									if(codigoTramo!=-1)
									{
										tramoActual = pistas.get(codigoTramo);
										if(tramoActual != null)
										{
											System.out.print(tramoActual+ " ");
											//leemos la altura y la desechamos
											leerEntero(st);
											//leemos el estado
											status = leerEntero(st);
											if(tramoActual.isCurva())
											{
												if(status==2) tramoActual.toggleOrientation();
												if(tramoActual.getCambioOrientacion())
													System.out.print("Curva Izquierda");
												else
													System.out.print("Curva Derecha");
											}
											System.out.println();
										} else errorCode = -7;
									} else errorCode = -6;
								} //end for
							} else errorCode = -5;
						} else errorCode = -4;
					} else errorCode = -3;
				} else errorCode = -2;
			} else errorCode = -1;
			
			switch(errorCode)
			{
			case 0:
				System.out.println("Parser de fichero realizado correctamente");
				break;
			case -1:
				System.out.println("Error en la estructura del fichero (Fabricante)");
				break;
			case -2:
				System.out.println("Fabricante no soportado ("+fabricante+")");
				break;
			case -3:
				System.out.println("Error en la estructura del fichero (Offset)");
				break;
			case -4:
				System.out.println("Error: numTRACKS no soportado. Debe ser 1 y es "+numTRACKS);
				break;
			case -5:
				System.out.println("Error en la estructura del fichero (numTramos)");
				break;
			case -6:
				System.out.println("Error en la estructura del fichero (codigo Tramo: "+codigoTramo+")");
				break;
			case -7:
				System.out.println("No se encuentra el tramo (codigo Tramo: "+codigoTramo+")");
				break;
			}
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("No se encuentra el fichero: "+fileNameInput);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	private int leerEntero(StreamTokenizer t) throws IOException
	{
		int ret = -1;
		int token = t.nextToken();
		if(token!=StreamTokenizer.TT_NUMBER) t.pushBack();
		else ret = (int)t.nval;
		
		return ret;
	}
	
	private float leerFloat(StreamTokenizer t) throws IOException
	{
		float ret = -1;
		int token = t.nextToken();
		if(token!=StreamTokenizer.TT_NUMBER) t.pushBack();
		else ret = (float)t.nval;
		
		return ret;
	}

	private String leerCadena(StreamTokenizer t) throws IOException
	{
		String ret = null;
		int token = t.nextToken();
		if(token!=StreamTokenizer.TT_WORD) t.pushBack();
		else ret = t.sval;
		
		return ret;
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
