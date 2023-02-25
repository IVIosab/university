#include <stdio.h>
#include <linux/input.h>


int main() {
	char* path = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
	FILE* event = fopen(path, "r");
	struct input_event input;
	while (1) {
		fread(&input, sizeof(struct input_event), 1,  event);
		if (input.type != EV_KEY) continue;
		if (input.value	== 0) {
			printf("RELEASED %#x (%d)\n", input.code, input.code);
		} else if (input.value == 1) {
			printf("PRESSED %#x (%d)\n", input.code, input.code);
		}
	}
}
