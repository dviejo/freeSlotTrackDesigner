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

public enum TramoPista {
	nincoRectaStd(0f, 400.0f, 0f, 400.0f, 400.0f, false, false),
	nincoRectaMedia(0f, 200.0f, 0f, 200.0f, 200.0f, false, false),
	nincoRectaCuarto(0f, 100.0f, 0f, 100.0f, 100.0f, false, false),
	nincoRectaOctavo(0f, 50.0f, 0f, 50.0f, 50.0f, false, false),
	//nincoCambioPista
	nincoCurvaInterior(44.41f, 107.215f, -45f, 154.429f, 83.743f, false, true),
	nincoCurvaInteriorMedia(11.542f, 58.024f, -22.5f, 77.2145f, 41.872f, false, true),
	nincoCurvaEstandar(70.77f, 170.855f, -45f, 295.8f, 225.115f, false, true),
	nincoCurvaEstandarMedia(18.393f, 92.466f, -22.5f, 147.9f, 112.557f, false, true),
	nincoCurvaExterior(38.945f, 195.790f, -22.5f, 218.586f, 183.243f, false, true),
	nincoCurvaSuperExterior(52.647f, 264.673f, -22.5f, 289.272f, 253.929f, false, true);
	
	public boolean getCambioOrientacion() {
		return cambioOrientacion;
	}

	public void setCambioOrientacion(boolean cambioOrientacion) {
		this.cambioOrientacion = cambioOrientacion;
	}
	
	public void toggleOrientation()
	{
		cambioOrientacion = !cambioOrientacion;
	}

	public float getPosX() {
		return posX;
	}

	public float getPosY() {
		return posY;
	}

	public float getLongIzquierdo() {
		return cambioOrientacion?longDerecho:longIzquierdo;
	}

	public float getLongDerecho() {
		return cambioOrientacion?longIzquierdo:longDerecho;
	}

	private float posX, posY, angulo;
	private float longIzquierdo, longDerecho;
	boolean cambioOrientacion;
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
	TramoPista(float x, float y, float a, float li, float ld, boolean cambio, boolean c)
	{
		posX = x;
		posY = y;
		setAngulo(a);
		longIzquierdo = li;
		longDerecho = ld;
		cambioOrientacion = cambio;
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
