NAME        := minishell

# --- DIRECTORIES ---

SRCDIR      := src
INCDIR      := inc
OBJDIR      := obj
LIBDIR      := libft

# --- SOURCES ---

SRC         := main.c init.c utils.c signals.c builtins_utils.c ft_cd.c \
               ft_pwd.c env.c ft_echo.c ft_env.c ft_export.c ft_unset.c \
               ft_exit.c pathing.c signals2.c ft_loop.c ft_free_shell.c \
               ft_free_tree.c ft_tree_nodes.c parse_cmd.c parse_redir.c \
               parse_redir_util.c exec.c handle_pipe.c handle_string.c \
               handle_string_1.c parse_exec.c redir.c handle_wo_pipe.c \
               handle_string_2.c init_1.c

SRCS        := $(addprefix $(SRCDIR)/, $(SRC))
OBJS        := $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))

# --- LIBRARIES ---

LIBFT       := $(LIBDIR)/libft.a

# --- FLAGS ---

CC          := cc
CFLAGS      := -Wall -Wextra -Werror -g -I$(INCDIR) -I$(LIBDIR)
LDLIBS      := $(LIBFT) -lreadline

# --- COMMANDS ---

RM          := rm -rf
MKDIR       := mkdir -p

# --- RULES ---

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(LIBFT) $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDLIBS) -o $(NAME)

$(LIBFT):
	$(MAKE) -C $(LIBDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@$(MKDIR) $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) $(OBJDIR)
	@$(MAKE) -C $(LIBDIR) clean

fclean: clean
	$(RM) $(NAME)
	@$(MAKE) -C $(LIBDIR) fclean

re: fclean all