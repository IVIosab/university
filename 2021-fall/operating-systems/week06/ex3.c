#include <stdbool.h>
#include "stdio.h"
#include "stdlib.h"

# define SIZE 15

int queue[SIZE];
int Rear = -1;
int Front = -1;
int emp = 0;

void enqueue(int process) {
    if (Rear != SIZE - 1) {
        if (Front == -1)
            Front = 0;
        Rear = Rear + 1;
        queue[Rear] = process;
    }
}

void dequeue() {
    if (Front == -1 || Front > Rear) {
        return;
    } else {
        Front = Front + 1;
    }
}

typedef struct ts {
    int brt;
    int arv;
} ts_t;

typedef struct tbl {
    ts_t *ts;
    int length;
} tbl_t;

tbl_t *parse(const char *fl) {
    FILE *in = fopen(fl, "r");
    if (in == NULL) {
        printf("No File %s found", fl);
        exit(1);
    }
    int cnt = 0;
    for (char c = getc(in); c != EOF; c = getc(in))
        if (c == '\n')
            cnt++;
    freopen(fl, "r", in);
    ts_t *timetbl = malloc(cnt * sizeof(ts_t));
    for (int i = 0; i < cnt; i++) {
        fscanf(in, "%d,%d", &timetbl[i].arv, &timetbl[i].brt);
    }
    fclose(in);
    tbl_t *tbl = malloc(sizeof(tbl_t));
    tbl->ts = timetbl;
    tbl->length = cnt;
    return tbl;
}

void free_tbl(tbl_t *tbl) {
    free(tbl->ts);
    free(tbl);
}

void swap(int *arv1, int *brt1, int *arv2, int *brt2) {
    int arvTmp = *arv1;
    int brtTmp = *brt1;
    *arv1 = *arv2;
    *brt1 = *brt2;
    *arv2 = arvTmp;
    *brt2 = brtTmp;
}

int main(int argc, char* argv[]) {
    char *end;
    const long qt = strtol(argv[1], &end, 10);
    tbl_t *tbl = parse("new_input.csv");
    int n = tbl->length;

    int at[n], bt[n], fbt[n], ct[n], tat[n], wt[n];
    for (int i = 0; i < n; i++) {
        at[i] = tbl->ts[i].arv;
        bt[i] = tbl->ts[i].brt;
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
    for(int i=0;i<n;i++){
        fbt[i]=bt[i];
    }
    int temp = qt;
    for (int i = 0; i < 25; i++) {
        for (int j = 0; j < n; j++) {
            if (at[j] == i) {
                enqueue(j);
                emp++;
            }
        }
        if (temp == 0) {
            temp = qt;
        }
        temp--;
        if (emp != 0) {
            bt[queue[Front]]--;
            if (bt[queue[Front]] == 0) {
                ct[queue[Front]] = i + 1;
                dequeue();
                emp--;
            } else if (temp == 0) {
                int tmpp = queue[Front];
                dequeue();
                emp--;
                if (bt[tmpp] != 0) {
                    enqueue(tmpp);
                    emp++;
                }
            }
        }


    }
    printf("P#\tAT\tBT\tCT\tTAT\tWT\n\n");
    double sum1 = 0, sum2 = 0;
    for (int i = 0; i < n; i++) {
        tat[i] = ct[i] - at[i];
        wt[i] = tat[i] - fbt[i];
        sum1 += tat[i];
        sum2 += wt[i];
        printf("P%d\t%d\t%d\t%d\t%d\t%d\n", i + 1, at[i], fbt[i], ct[i], tat[i], wt[i]);
    }
    printf("Average Turnaround Time = %f\n", (sum1 / (double) n));
    printf("Average WT = %f\n", (sum2 / (double) n));

    free(tbl);
}
