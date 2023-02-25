#include "stdio.h"
#include "stdlib.h"

typedef struct process {
    int bt;
    int at;
} line;

typedef struct csvFile {
    line *process;
    int size;
} csvFile;

csvFile *parseFile(const char *fileName) {
    FILE *file = fopen(fileName, "r");
    if (file == NULL) {
        printf("file not found");
        exit(1);
    }
    int sz = 0;
    for (char c = getc(file); c != EOF; c = getc(file)) {
        if (c == '\n') {
            sz++;
        }
    }

    freopen(fileName, "r", file);
    line *process = malloc(sz * sizeof(line));
    for (int i = 0; i < sz; i++) {
        fscanf(file, "%d,%d", &process[i].at, &process[i].bt);
    }
    fclose(file);
    csvFile *csvFile = malloc(sizeof(csvFile));
    csvFile->process = process;
    csvFile->size = sz;
    return csvFile;
}

void swap(int *arv1, int *brt1, int *arv2, int *brt2) {
    int arvt = *arv1;
    int brtt = *brt1;
    *arv1 = *arv2;
    *brt1 = *brt2;
    *arv2 = arvt;
    *brt2 = brtt;
}

int main() {
    csvFile *csvFile = parseFile("new_input.csv");

    int n = csvFile->size;
    int at[n], bt[n], ct[n], tat[n], wt[n];
    float averagetat = 0;
    float averagewt = 0;
    for (int i = 0; i < n; i++) {
        at[i] = csvFile->process[i].at;
        bt[i] = csvFile->process[i].bt;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (at[j] > at[j+1]) {
                swap(&at[j], &bt[j], &at[j+1], &bt[j+1]);
            } else if (at[j] == at[j+1]) {
                if (bt[j] < bt[j+1]) {
                    swap(&at[j], &bt[j], &at[j+1], &bt[j+1]);
                }
            }
        }
    }


    wt[0] = 0;
    tat[0] = bt[0];

    for (int i = 0; i < n; i++) {
        ct[i] = at[i] + tat[i];
        if (i + 1 < n) {
            if (ct[i] > at[i + 1]) {
                wt[i + 1] = ct[i] - at[i + 1];
            } else {
                wt[i + 1] = 0;
            }
            tat[i + 1] = bt[i + 1] + wt[i + 1];
        }

    }
    for (int (i) = 0; (i) < n; ++(i)) {
        averagetat += tat[i];
        averagewt += wt[i];
    }

    averagetat = averagetat / n;
    averagewt = averagewt / n;

    printf("P#\tat\tbt\tct\ttat\twt\n\n");

    for (int i = 0; i < n; i++) {
        printf("P%d\t%d\t%d\t%d\t%d\t%d\n", i, at[i], bt[i], ct[i], tat[i], wt[i]);
    }

    printf("\nAverage Turnaround Time = %f\n", averagetat);
    printf("Average wt = %f\n", averagewt);
    free(csvFile->process);
    free(csvFile);
}
