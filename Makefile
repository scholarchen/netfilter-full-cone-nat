KVER   ?= $(shell uname -r)
KDIR   ?= /lib/modules/$(KVER)/build/
IPTABLESDIR ?= /usr
#KDIR = ../../develop/iposv1.1build/branch/src/kernel/linux-3.18.27
#IPTABLESDIR = ./iptables
DEPMOD  = /sbin/depmod -a
CC     ?= gcc
obj-m   = xt_FULLCONENAT.o
xt_FULLCONENAT.o := -DDEBUG
SOCFLAGS := -I $(IPTABLESDIR)/include 
SOLIBFLAGS := -L $(IPTABLESDIR)/lib/xtables


all:  xt_FULLCONENAT.ko libipt_FULLCONENAT.so
	
xt_FULLCONENAT.ko:xt_FULLCONENAT.c
	make -C $(KDIR) M=$(CURDIR) modules CONFIG_DEBUG_INFO=y
	-sync

libipt_FULLCONENAT.so: libipt_FULLCONENAT.o
	$(CC) -shared -lxtables $(SOLIBFLAGS) -o $@ $^;
libipt_FULLCONENAT.o: libipt_FULLCONENAT.c
	$(CC) $(SOCFLAGS) -fPIC  -c -o $@ $<;

clean:
	make -C $(KDIR) M=$(CURDIR) clean
	-rm -f *.so *.o 
	

