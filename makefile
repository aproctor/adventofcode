
all: day4

day4:
	gcc -Wall day4.c -o bin/day4
	chmod a+x bin/day4

clean:
	rm -rf bin/*
