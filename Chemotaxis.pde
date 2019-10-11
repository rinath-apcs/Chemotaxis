Bacteria[] bacteria;
void setup() {
	size(1000, 1000);
	bacteria = new Bacteria[50];

	for (int i = 0; i < bacteria.length; i++) {
		bacteria[i] = new Bacteria();
	}

}

void draw() {
	background(177);
	for (Bacteria germ : bacteria) {
		germ.show();
	}
}

class Bacteria {
	float x, y, vel, dir, dirVel;

	Bacteria() {
		x = random(width);
		y = random(height);
		vel = random(2);
		dir = random(TWO_PI);
		dirVel = random(-0.1, 0.1);
	}

	void show() {
		x += vel * cos(dir);
		y += vel * sin(dir);
		dir += dirVel;

		ellipse(x, y, 5, 5);
	}
}