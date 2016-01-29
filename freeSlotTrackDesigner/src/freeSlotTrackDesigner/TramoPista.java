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
	nincoCurvaInterior(44.41f, 107.215f, -45f, 154.429f, 83.743f, false),
	nincoCurvaInteriorMedia(11.542f, 58.024f, -22.5f, 77.2145f, 41.872f, false),
	nincoCurvaEstandar(70.77f, 170.855f, -45f, 295.8f, 225.115f, false),
	nincoCurvaEstandarMedia(18.393f, 92.466f, -22.5f, 147.9f, 112.557f, false),
	nincoCurvaExterior(70.77f, 170.855f, -45f, 295.8f, 225.115f, false),
	nincoCurvaSuperExterior(70.77f, 170.855f, -45f, 295.8f, 225.115f, false);
	
	public boolean getCambioOrientacion() {
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
		setAngulo(a);
		longIzquierdo = li;
		longDerecho = ld;
		cambioOrientacion = cambio;
	}

	public float getAngulo() {
		return angulo;
	}

	public void setAngulo(float angulo) {
		this.angulo = angulo;
	}

}
