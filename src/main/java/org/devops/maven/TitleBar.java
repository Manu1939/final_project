package org.devops.maven;

import java.awt.Dimension;
import java.awt.Font;

import javax.swing.JLabel;
import javax.swing.JPanel;

public class TitleBar extends JPanel{

    /** 
	 * 
	 */
	private static final long serialVersionUID = 1L;

	TitleBar()
    {
        this.setPreferredSize(new Dimension(400,80));

        JLabel titleText = new JLabel("Schedule");
        titleText.setPreferredSize(new Dimension(200,60));
        titleText.setFont(new Font("Sans-serif",Font.BOLD, 20));
        titleText.setHorizontalAlignment(JLabel.CENTER);
        this.add(titleText);
    }
}