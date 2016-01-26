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
	nincoRectaStd(0f, 400.0f, 0f, 400.0f, 400.0f, false),
	nincoRectaMedia(0f, 200.0f, 0f, 200.0f, 200.0f, false),
	nincoRectaCuarto(0f, 100.0f, 0f, 100.0f, 100.0f, false),
	nincoRectaOctavo(0f, 50.0f, 0f, 50.0f, 50.0f, false),
	//nincoCambioPista
	nincoCurvaInterior();
	
	public boolean isCambioOrientacion() {
		return cambioOrientacion;
	}

	public void setCambioOrientacion(boolean cambioOrientacion) {
		this.cambioOrientacion = cambioOrientacion;
	}

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
	boolean cambioOrientacion;
	
	TramoPista(float x, float y, float a, float li, float ld, boolean cambio)
	{
		posX = x;
		posY = y;
		angulo = a;
		longIzquierdo = li;
		longDerecho = ld;
		cambioOrientacion = cambio;
	}

}
