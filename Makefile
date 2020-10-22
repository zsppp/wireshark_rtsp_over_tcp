#############################################
# 用户设置变量说明
#############################################
# NAME : 模块名称
# BUILD_TARGET_TYPE : 编译目标类型,取值static, exe, dll
# INCDIR : 搜索目录列表(目前前加 -I)
# SRC : 源码文件
# TEST_SRC : 测试源码文件
# BINDIR : 生成库或可执行文件的路径
# DYN_LDS_WITH : 需要动态链接的库
# STATIC_LDS_WITH : 需要静态链接的库
# DEPS_TARGET : 扩展依赖对象
#
# DEBUG : 是否debug, 取值(y,n)
# PRINT_COMPILER : 是否打印编译信息, 取值(y, n)
#
# AR : 函数库打包器
# AS : 汇编器
# CC : C编译器
# CXX : C++编译器
# CPP : C预处理器
# LD : 链接器
# ARFLAGS : 函数库打包选项
# ASFLAGS : 汇编选项
# CFLAGS : C编译选项
# CXXFLAGS : C++编译选项
# CPPFLAGS : C预处理选项
# LDFLAGS : 链接选项
# RM : 删除命令，默认是"rm -f"
#############################################
##############################################
#   初始设置build输出目录
##############################################

CC = gcc
CXX = g++
TARGET = demo
SRC_PATH = wireshark_rtsp_over_tcp
OBJ_PATH = obj
BIN_PATH = bin
#SRC = $(shell find ./ -name "*.c")
SRC = $(shell find $(SRC_PATH) -name "*.cpp")
#CFLAGS += -lm
#CFLAGS += -lpthread
#INC += -I./include

# 编译条件设置
DEBUG = n
ifeq ($(DEBUG), y)
CFLAGS += -g
else
CFLAGS += -O2
endif

OBJ += $(patsubst %.c,$(OBJ_PATH)/%.o,$(patsubst %.cpp,$(OBJ_PATH)/%.o,$(SRC)))
BIN = $(BIN_PATH)/$(TARGET)

$(BIN) : $(OBJ)
	mkdir -p $(dir $@)
	$(CXX) -o $@ $(OBJ) $(CFLAGS)

$(OBJ_PATH)/%.o: %.cpp
	@echo '<$(CXX)>[$(DEBUG)] Compiling object file "$@" ...'
	mkdir -p $(dir $@)
	$(CXX) -c $< -o $@ $(CFLAGS)

.PHONY:clean
clean :
	rm -rf $(BIN) $(OBJ)


