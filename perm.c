/* perm.c -- permutations of the command line parameters.
 * Author: Luis Colorado <luiscoloradourcola@gmail.com>
 * Date: Mon Mar  9 19:26:57 EET 2020
 * Copyright: (C) 2020 Luis Colorado.  All rights reserved.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <getopt.h>


void ex(char **a, char **b)
{
	if (a == b) return;

	char *p = *a;
	*a = *b;
	*b = p;
}

char **all;
char *separator = ", ";
char *lsep = "\n";
char *psep = "";

void permuta(int argc, char **argv)
{
	int i;

	if (argc <= 0) {
		char *sep, **arg;
		printf("%s", psep);
		psep = lsep;
		for (sep = "", arg = all;
				*arg; arg++) {
			printf("%s%s", sep, *arg);
			sep = separator;
		}

		return;
	}
	for (i = 0; i < argc; i++) {
		ex(&argv[0], &argv[i]);
		permuta(argc-1, argv+1);
		ex(&argv[0], &argv[i]);
	}
}

int main(int argc, char **argv)
{
	int opt;

	while ((opt = getopt(argc, argv, "s:l:")) >= 0) {
		switch (opt) {
		case 's': separator = optarg; break;
		case 'l': lsep = optarg; break;
		}
	}

	argc -= optind; argv += optind;
	all = argv;

	/* the following code "interns" all strings, so
	 * if the pointers are equal, the strings are equal,
	 * without the need to allocate memory */
	int i;
	for(i = 0; i < argc-1; i++) {
		int j;
		for (j = i + 1; j < argc; j++) {
			if (0 == strcmp(argv[i], argv[j]))
				argv[j] = argv[i];
		}
	}

	permuta(argc, argv);
	puts("");
}
