COMP = ghc
FLAGS = -O

DIR = bin
SRC = Stoichiometry.hs
EXE = bin/stoichiometry

.PHONY: all clean sure

# Rules
all: $(DIR) $(SRC)
	ghc -o $(EXE) $(SRC)

clean:
	@rm -rf $(DIR)

sure: clean all

# Utilities
$(DIR):
	@mkdir $(DIR)
