.PHONY: all update-submodule

# Path to scripts
SCRIPTS_DIR := scripts

## Update the Thanos Operator submodule (default: main)
update-submodule:
	$(SCRIPTS_DIR)/update-submodule.sh

