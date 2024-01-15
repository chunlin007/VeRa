# Script to easy the use of vera
FUZZROOT ?= ~/FuzzBase
FIRMNAME ?= Modbus
RUNNUM ?= 1.0
FIRMDIR = $(FUZZROOT)/$(FIRMNAME)/$(RUNNUM)

run:
	FUZZDIR=$(FUZZROOT) ./fuzz.py -c ./Configs/$(FIRMNAME).cfg 

clean:
	rm -rf $(FIRMDIR)/[0-9]* $(FIRMDIR)/me*.log $(FIRMDIR)/outputs	$(FIRMDIR)/mi-*

# Recovery output
disp:
	stty echo && echo -e "\033[?25h" #&& trap INT


.PHONY:
	clean
