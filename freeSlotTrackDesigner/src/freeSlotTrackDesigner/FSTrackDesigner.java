/**
 * 
 */
package freeSlotTrackDesigner;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GraphicsConfiguration;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 * @author dviejo
 *
 */
public class FSTrackDesigner extends JFrame {

	private static final long serialVersionUID = 300657496211191695L;

	/**
	 * @throws HeadlessException
	 */
	public FSTrackDesigner() throws HeadlessException {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param gc
	 */
	public FSTrackDesigner(GraphicsConfiguration gc) {
		super(gc);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param title
	 * @throws HeadlessException
	 */
	public FSTrackDesigner(String title) throws HeadlessException {
		super(title);
		this.setLayout(new BorderLayout());
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JPanel areaBotones = new JPanel();
		areaBotones.setLayout(new FlowLayout());
		this.add(areaBotones, BorderLayout.EAST);

		// Boton para ejecutar el algoritmo
		JButton botonEjemplo = new JButton("Ejemplo");
		botonEjemplo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.out.println("Has hecho click en el botón");
			}
		});
		areaBotones.add(botonEjemplo);

	}

	/**
	 * @param title
	 * @param gc
	 */
	public FSTrackDesigner(String title, GraphicsConfiguration gc) {
		super(title, gc);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		FSTrackDesigner td = new FSTrackDesigner("Free Slot Track Designer");
		td.setVisible(true);

	}

}
