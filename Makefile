CC=gcc

NAME=libcstd<lib>.a
MAIN_NAME=libtest
TEST_NAME=unitest

SRC=src/
UNITTEST_SRC=tests/unitest/
CFLAGS += -O3 -Ofast -Wall

CFLAGS_DEBUG += -Wall -Werror -g2 -fanalyzer -Wextra -Wundef

OBJ=${patsubst %c, %o, ${SRC}}
OBJ_DEBUG=${patsubst %c, %o_debug, ${SRC}}

OBJ_TEST=${patsubst %c, %o_debug, ${UNITTEST}}

RM=rm -rf

%.o: %.c
	${CC} ${CFLAGS} -c -o $@ $<

%.o_debug: %.c
	${CC} ${CFLAGS_DEBUG} -c -o $@ $<

all: ${NAME}

${NAME}: ${OBJ}
	ar rc $(NAME) $^

debug: ${OBJ_DEBUG}
	ar rc ${NAME} $^

tests: debug ${OBJ_TEST}
	gcc ${CFLAGS_DEBUG} tests/main.c -L. -l<lib>
	gcc ${CFLAGS_DEBUG} ${OBJ_TEST} -L. -l<lib> -l <unit lib> -o unittest

clean:
	${RM} ${OBJ} ${OBJ_DEBUG} ${OBJ_TEST}

fclean: clean
	${RM} ${NAME} ${MAIN_NAME} ${TEST_NAME}

re: fclean all

.PHONY: all ${NAME} debug tests clean re fclean
