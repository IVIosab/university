#include <stdio.h>
#include <linux/input.h>
#include <fcntl.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>

#define PRESSED (1)
#define RELEASED (0)

struct shortcut {
    int* sequence;
    int* states;
    int len;
    char* value;
    char* hint;
};

int main() {
    struct shortcut* cap = (struct shortcut*)malloc(sizeof(struct shortcut) * 1);
    cap->len = 3;
    cap->sequence = (int*)malloc(sizeof(int) * cap->len);
    cap->sequence[0] = KEY_C;
    cap->sequence[1] = KEY_A;
    cap->sequence[2] = KEY_P;
    cap->states = (int*)calloc(0, sizeof(int) * cap->len);
    cap->value = "Get some cappuccino!";
    cap->hint = "cap";

    struct shortcut* pe = (struct shortcut*)malloc(sizeof(struct shortcut) * 1);
    pe->len = 2;
    pe->sequence = (int*)malloc(sizeof(int) * pe->len);
    pe->sequence[0] = KEY_P;
    pe->sequence[1] = KEY_E;
    pe->states = (int*)calloc(0, sizeof(int) * pe->len);
    pe->value = "I passed the Exam!";
    pe->hint = "pe";

    struct shortcut* mos = (struct shortcut*)malloc(sizeof(struct shortcut) * 1);
    mos->len = 3;
    mos->sequence = (int*)malloc(sizeof(int) * mos->len);
    mos->sequence[0] = KEY_M;
    mos->sequence[1] = KEY_O;
    mos->sequence[2] = KEY_S;
    mos->states = (int*)calloc(0, sizeof(int) * mos->len);
    mos->value = "MOSAB IS IN THE HOUSE";
    mos->hint = "mos";

    struct shortcut** list_of_shortcuts = malloc(sizeof(struct shortcut*) * 3);
    list_of_shortcuts[0] = cap;
    list_of_shortcuts[1] = pe;
    list_of_shortcuts[2] = mos;

    int shortcuts_size = 3;
    printf("Available shortcuts \n");
    for (int i = 0; i < shortcuts_size; i++) {
        printf("%s -> %s\n", list_of_shortcuts[i]->hint, list_of_shortcuts[i]->value);
    }

    char* path = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
    FILE* events = fopen(path, "r");
    struct input_event input;
    while (1) {
        fread(&input, sizeof(struct input_event), 1,  events);
        if (input.type != EV_KEY) continue;
        if (!(input.value == PRESSED || input.value == RELEASED)) continue;
        if (input.value == 2) continue;

        for (int i = 0; i < shortcuts_size; i++) {
            struct shortcut* cur = list_of_shortcuts[i];
            for (int seq_idx = 0; seq_idx < cur->len; seq_idx++) {
                if (cur->sequence[seq_idx] == input.code) {
                    if (input.value == PRESSED && (seq_idx == 0 || cur->states[seq_idx - 1] == PRESSED))
                        cur->states[seq_idx] = input.value;

                    if (input.value == RELEASED) {
                        for (int j = seq_idx; j >= 0; j--) {
                            cur->states[j] = RELEASED;
                        }
                    }
                }
            }
            if (cur->states[cur->len - 1] == PRESSED) {
                printf("\n\n%s\n\n", cur->value);
                for (int seq_idx = 0; seq_idx < cur->len; seq_idx++) {
                    cur->states[seq_idx] = RELEASED;
                }
            }
        }
    }
}
