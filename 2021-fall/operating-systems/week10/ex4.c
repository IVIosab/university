#include <dirent.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>

int main() {
    int fc = 0;
    char **fn = malloc(sizeof(char) * 256);
    int *inh = malloc(sizeof(int) * 256);

    DIR *dir_pointer = opendir("tmp");
    struct dirent *d;
    struct stat *s;
    while ((d = readdir(dir_pointer)) != NULL) {
        stat(d->d_name, s);
        fn[fc] = d->d_name;
        inh[fc] = d->d_ino;
        fc++;
    }

    for (int i = 0; i < fc; i++) {
        int oc = 0;
        for (int j = 0; j < fc; j++) {
            if (inh[i] == inh[j]) oc++;
        }
        if (oc >= 2) {
            printf("%s: ", fn[i]);
            for (int j = 0; j < fc; j++) {
                if (inh[i] == inh[j] &&
                    fn[i] != fn[j])
                    printf("%s ", fn[j]);
            }
            printf("\n");
        }
    }
}
