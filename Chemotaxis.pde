Kite[] kites;
ArrayList<Press> presses;
int springy;

void setup() {
	size(1000, 1000);

	springy = 0;
	kites = new Kite[50];
	presses = new ArrayList();

	for (int i = 0; i < kites.length; i++) {
		kites[i] = new Kite();
	}

}

void draw() {
	background(177);

	for (Press press : presses) {
		press.tick(springy);
	}

	for (Kite kite : kites) {
		kite.tick(springy);
	}

	if (mousePressed) {
		springy++;
	} else {
		springy = 0;
	}
}

class Kite {
	private float x, y, dir, dirVel, tempVel, vel;
	private int col;

	private final int size = 4;
	private final int colorRange = 25;

	public Kite() {
		x = (float) Math.random() * width;
		y = (float) Math.random() * height;
		vel = (float) Math.random() * 3 + 2;
		dir = (float) Math.random() * TWO_PI;
		dirVel = (float) Math.random() * 0.3 - 0.3;
		col = color((int) (Math.random() * colorRange + 255 - colorRange), (int) (Math.random() * colorRange + 255 - colorRange), (int) (Math.random() * colorRange + 255 - colorRange));
		tempVel = 0;
	}

	private void show() {
		stroke(0);
		fill(col);
		triangle(x + 5 * size * cos(dir), y + 5 * size * sin(dir), x + size * 2, y + size * 2, x - size * 2, y - size * 2);
	}

	private void move() {
		x += (vel + tempVel) * cos(dir);
		y += (vel + tempVel) * sin(dir);
		if (vel + tempVel > 0) 
			dir += dirVel;

		if (x > width) {
			x = 0;
		} else if (x < 0) {
			x = width;
		}
		if (y > height) {
			y = 0;
		} else if (y < 0) {
			y = height;
		}

		if (tempVel > 0) {
			tempVel *= 0.99;
		} else if (tempVel < 0 && !mousePressed) {
			tempVel += 0.1;
		}


		if (random(dirVel * 100) > 19) {
			dirVel = (float) Math.random() * 0.3 - 0.3;
		}
	}

	public void tick(float springy) {
		if (mousePressed) {
			slow();
		} else {
			boost(springy);
		}

		move();
		show();
	}

	public void boost(float speed) {
		tempVel += speed;
	}

	private void slow() {
		if (vel + tempVel > 0) {
			tempVel -= 0.05;
		} else {
			tempVel = -vel;
		}
	}
}

class Press {
	private float radius, x, y;
	private boolean boosted;

	public Press() {
		radius = width;
		boosted = false;
		x = mouseX;
		y = mouseY;
	}

	public void tick(int counter) {
		if (mousePressed && !boosted) {
			radius = width * 2 - ((width * 2 - width / 20.0) * counter * counter) / ((counter * counter + 150.0));
		} else {
			boosted = true;
			if (radius < width * 3) {
				radius *= 1.2;
			}
		}

		show();
	}

	private void show() {
		noStroke();
		fill(radius / 15.0 < 78 ? 177 + (78 - radius / 15.0) : 177);
		ellipse(x, y, radius, radius);
	}
}

public void mousePressed() {
	presses.add(new Press());
}