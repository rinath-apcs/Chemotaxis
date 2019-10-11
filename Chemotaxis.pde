Bacteria[] bacteria;
int springy;

void setup() {
	springy = 0;
	size(1000, 1000);
	bacteria = new Bacteria[50];

	for (int i = 0; i < bacteria.length; i++) {
		bacteria[i] = new Bacteria();
	}

}

void draw() {
	background(177);
	for (Bacteria germ : bacteria) {
		germ.show(mousePressed);
	}

	if (mousePressed) {
		springy++;
	} else {
		for (Bacteria germ : bacteria) {
			germ.boost(springy);
		}
		springy = 0;
	}
}

class Bacteria {
	private float x, y, dir, dirVel;
	private float tempVel, vel;

	public Bacteria() {
		x = random(width);
		y = random(height);
		vel = random(2, 4);
		dir = random(TWO_PI);
		dirVel = random(-0.3, 0.3);
		tempVel = 0;
	}

	public void show(boolean pressed) {
		if (pressed) slow();

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
		} else if (tempVel < 0 && !pressed) {
			tempVel += 0.1;
		}


		if (random(dirVel * 100) > 19) {
			dirVel =  random(-0.3, 0.3);
		}

		triangle(x + 10 * cos(dir), y + 10 * sin(dir), x + 4, y + 4, x - 4, y - 4);
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