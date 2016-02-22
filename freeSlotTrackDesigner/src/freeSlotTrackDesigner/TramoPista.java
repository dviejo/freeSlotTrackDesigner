/**
 * 
 */
package freeSlotTrackDesigner;

/**
 * @author dviejo
 *
 * Tramos de pista de slot
 * 
 * Asumimos que todos los tramos de curva giran a la derecha si no se especifica lo contrario
 */

public class TramoPista
{
	private TramoPistaE tipoTramo;
	private boolean cambio; 
	
	public TramoPista(TramoPistaE tipo)
	{
		tipoTramo = tipo;
		cambio = false;
	}

	public boolean isCurva()
	{
		return tipoTramo.isCurva();
	}
	/**
	 * @return the tipoTramo
	 */
	public TramoPistaE getTipoTramo() {
		return tipoTramo;
	}


	public boolean getCambioOrientacion() {
		return cambio;
	}

	public void setCambioOrientacion(boolean cambioOrientacion) {
		this.cambio = cambioOrientacion;
	}
	
	public void toggleOrientation()
	{
		cambio = !cambio;
	}

	public float getLongIzquierdo() {
		return cambio?tipoTramo.getLongDerecho():tipoTramo.getLongIzquierdo();
	}

	public float getLongDerecho() {
		return cambio?tipoTramo.getLongIzquierdo():tipoTramo.getLongDerecho();
	}
	
	/**
	 * 
	 * @author dviejo
	 *
	 * Tracks are modeled by its center in the X axis
	 */
	public enum TramoPistaE {
		nincoRectaStd(0f, 400.0f, 0f, 400.0f, 400.0f, false),
		nincoRectaMedia(0f, 200.0f, 0f, 200.0f, 200.0f, false),
		nincoRectaCuarto(0f, 100.0f, 0f, 100.0f, 100.0f, false),
		nincoRectaOctavo(0f, 50.0f, 0f, 50.0f, 50.0f, false),
		//nincoCambioPista
		nincoCurvaInterior(44.41f, 107.215f, -45f, 154.2286f, 83.5428f, true),
		nincoCurvaInteriorMedia(11.542f, 58.024f, -22.5f, 77.1143f, 41.7714f, true),
		nincoCurvaEstandar(70.77f, 170.855f, -45f, 295.8f, 225.115f, true),
		nincoCurvaEstandarMedia(18.393f, 92.466f, -22.5f, 147.9f, 112.557f, true),
		nincoCurvaExterior(38.945f, 195.790f, -22.5f, 218.586f, 183.243f, true),
		nincoCurvaSuperExterior(52.647f, 264.673f, -22.5f, 289.272f, 253.929f, true);
		
	
		public float getPosX() {
			return posX;
		}
	
		public float getPosY() {
			return posY;
		}
	
		public float getLongIzquierdo() {
			return longIzquierdo;
		}
	
		public float getLongDerecho() {
			return longDerecho;
		}
	
		private float posX, posY, angulo;
		private float longIzquierdo, longDerecho;
//		boolean cambioOrientacion;
		boolean curva;
		
		/**
		 * 
		 * @param x Posición X de la siguiente pista tras insertar este tramo. Expresado en mm.
		 * @param y Posición Y de la siguiente pista tras insertar este tramo. Expresado en mm.
		 * @param a Angulo de la pista tras insertar este tramo. Expresado en grados.
		 * @param li Longitud recorrida por el carril izquierdo. Expresado en mm.
		 * @param ld Longitud recorrida por el carril derecho. Expresado en mm.
		 * @param cambio Indica si se produce un cambio en el giro de la recta. False: giro a la derecha, True: giro a la izquierda.
		 */
		TramoPistaE(float x, float y, float a, float li, float ld, boolean c)
		{
			posX = x;
			posY = y;
			setAngulo(a);
			longIzquierdo = li;
			longDerecho = ld;
//			cambioOrientacion = cambio;
			curva = c;
		}
	
		public boolean isCurva() {
			return curva;
		}
	
		public float getAngulo() {
			return angulo;
		}
	
		public void setAngulo(float angulo) {
			this.angulo = angulo;
		}
	
	}

}