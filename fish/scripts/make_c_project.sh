PROJECT_NAME=$1
PROJECT_PATH="$(pwd)/${PROJECT_NAME}"

if [ -d "${PROJECT_PATH}" ]; then
  echo "错误：目录 '${PROJECT_PATH}' 已存在！" >&2
  exit 1
fi

mkdir "${PROJECT_PATH}" || exit 1
cd ${PROJECT_PATH} || exit 1

mkdir -p src include include/lib build bin
touch Makefile src/main.c include/hello.h

cat <<EOF >include/hello.h
#ifndef HELLO_H
#define HELLO_H

void hello(void);

#endif /* HELLO_H */

EOF

cat <<EOF >src/main.c
#include "../include/hello.h"
#include <stdio.h>

void hello() {
  printf("Hello ${PROJECT_NAME}! \n");
}

int main() {
  printf("Hello make_c_project.sh! \n");
  hello();
  return 0;
}

EOF

cat <<EOF >Makefile
# Makefile for ${PROJECT_NAME}
CC := gcc
CFLAGS := -Iinclude -Wall -Wextra -g
SRC_DIR := src
BUILD_DIR := build
BIN_DIR := bin

PROJECT := ${PROJECT_NAME}
TARGET := \$(BIN_DIR)/\$(PROJECT)
SRCS := \$(wildcard \$(SRC_DIR)/*.c)
OBJS := \$(patsubst \$(SRC_DIR)/%.c,\$(BUILD_DIR)/%.o,\$(SRCS))

.PHONY: all clean run

all: \$(TARGET)

\$(TARGET): \$(OBJS) | \$(BIN_DIR)
	@echo "Linking \$@"
	\$(CC) $^ -o \$@

\$(BUILD_DIR)/%.o: \$(SRC_DIR)/%.c | \$(BUILD_DIR)
	@echo "Compiling \$<"
	\$(CC) \$(CFLAGS) -c \$< -o \$@

\$(BUILD_DIR) \$(BIN_DIR):
	@mkdir -p \$@

clean:
	@echo "Cleaning project"
	@rm -rf \$(BUILD_DIR) \$(BIN_DIR)

run: \$(TARGET)
	@echo "Running \$(TARGET)"
	@\$(TARGET)
EOF

echo "项目 '${PROJECT_NAME}' 创建成功！"
