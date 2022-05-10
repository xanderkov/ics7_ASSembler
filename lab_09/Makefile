# Компилятор
CC := gcc

# Флаги компиляции
CFLAGS := -Wall -Wextra -Wpedantic -Iinc -g

# Фиктивные цели
.PHONY: all clean

all: out/prof+x87 out/prof-x87 out/prec

out/prof+x87: CFLAGS += -DX87
out/prof+x87: src/prof.c inc/prof.h
	$(CC) $(CFLAGS) $< -o $@

out/prof-x87: CFLAGS += -mno-80387
out/prof-x87: src/prof.c inc/prof.h
	$(CC) $(CFLAGS) $< -o $@

out/prec: src/prec.c inc/prec.h
	$(CC) $(CFLAGS) $< -o $@

clean:
	$(RM) out/*


clean:
	rm -f *.o
	rm -f *.s
	rm -f *.out
	rm -rf $(OUT)